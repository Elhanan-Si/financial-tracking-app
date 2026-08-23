import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/accounts/presentation/screens/accounts_list_screen.dart';
import '../../features/adaptive_shell/presentation/adaptive_scaffold.dart';
import '../../features/auth_lock/presentation/controllers/auth_controller.dart';
import '../../features/auth_lock/presentation/screens/lock_screen.dart';
import '../../features/auth_lock/presentation/screens/security_settings_screen.dart';
import '../../features/backup_settings/presentation/screens/settings_hub_screen.dart';
import '../../features/budgets/presentation/screens/budget_planning_screen.dart';
import '../../features/budgets/presentation/screens/budgets_screen.dart';
import '../../features/cash_flow/presentation/screens/cash_flow_forecast_screen.dart';
import '../../features/cash_flow/presentation/screens/credit_card_forecast_screen.dart';
import '../../features/categories_tags/presentation/screens/categories_management_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/auto_categorization/presentation/screens/category_rules_screen.dart';
import '../../features/auto_categorization/presentation/screens/uncategorized_transactions_screen.dart';
import '../../features/import_export/presentation/screens/import_batches_history_screen.dart';
import '../../features/import_export/presentation/screens/import_upload_screen.dart';
import '../../features/insights_analytics/presentation/screens/insights_screen.dart';
import '../../features/investments/presentation/screens/holding_detail_screen.dart';
import '../../features/investments/presentation/screens/investments_screen.dart';
import '../../features/net_worth/presentation/screens/net_worth_screen.dart';
import '../../features/non_market_assets/presentation/screens/non_market_assets_screen.dart';
import '../../features/pension_assets/presentation/screens/pension_assets_screen.dart';
import '../../features/recurring/presentation/screens/recurring_list_screen.dart';
import '../../features/transactions/presentation/screens/transaction_detail_screen.dart';
import '../../features/transactions/presentation/screens/transactions_list_screen.dart';
import '../../features/transfers/presentation/screens/transfer_screen.dart';
import 'route_names.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNav');
final _shellNavigatorDashboardKey = GlobalKey<NavigatorState>(debugLabel: 'dashboardNav');
final _shellNavigatorTransactionsKey = GlobalKey<NavigatorState>(debugLabel: 'transactionsNav');
final _shellNavigatorBudgetsKey = GlobalKey<NavigatorState>(debugLabel: 'budgetsNav');
final _shellNavigatorInvestmentsKey = GlobalKey<NavigatorState>(debugLabel: 'investmentsNav');
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'settingsNav');

/// Listenable bridge for Riverpod StateNotifier to trigger GoRouter redirection on auth changes
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  final refreshListenable = GoRouterRefreshStream(authController.stream);
  ref.onDispose(refreshListenable.dispose);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.dashboard,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final isGoingToLock = state.matchedLocation == AppRoutes.lock;

      // Strict security: if not authenticated, redirect to /lock
      if (!authState.isAuthenticated) {
        return isGoingToLock ? null : AppRoutes.lock;
      }

      // If authenticated and on lock screen, navigate to dashboard
      if (isGoingToLock) {
        return AppRoutes.dashboard;
      }

      return null;
    },
    routes: [
      // Lock & Setup Screen (Screen 23)
      GoRoute(
        path: AppRoutes.lock,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const LockScreen(),
      ),

      // Direct modals and screens
      GoRoute(
        path: AppRoutes.transfers,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const TransferScreen(),
      ),
      GoRoute(
        path: AppRoutes.recurring,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const RecurringListScreen(),
      ),
      GoRoute(
        path: AppRoutes.budgetPlanning,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const BudgetPlanningScreen(),
      ),
      GoRoute(
        path: AppRoutes.creditCardForecast,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CreditCardForecastScreen(),
      ),
      GoRoute(
        path: AppRoutes.cashFlow,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CashFlowForecastScreen(),
      ),
      GoRoute(
        path: AppRoutes.importData,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ImportUploadScreen(),
      ),
      GoRoute(
        path: AppRoutes.importHistory,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ImportBatchesHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.uncategorizedTransactions,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const UncategorizedTransactionsScreen(),
      ),
      GoRoute(
        path: AppRoutes.categoryRules,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CategoryRulesScreen(),
      ),

      // Main Stateful Shell Route for Adaptive Scaffold
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AdaptiveScaffold(navigationShell: navigationShell);
        },
        branches: [
          // 1. Dashboard Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDashboardKey,
            routes: [
              GoRoute(
                path: AppRoutes.dashboard,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),

          // 2. Transactions Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorTransactionsKey,
            routes: [
              GoRoute(
                path: AppRoutes.transactions,
                builder: (context, state) => const TransactionsListScreen(),
                routes: [
                  GoRoute(
                    path: 'detail/:id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => TransactionDetailScreen(
                      transactionId: state.pathParameters['id'] ?? '',
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 3. Budgets Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBudgetsKey,
            routes: [
              GoRoute(
                path: AppRoutes.budgets,
                builder: (context, state) => const BudgetsScreen(),
              ),
            ],
          ),

          // 4. Investments & Assets Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorInvestmentsKey,
            routes: [
              GoRoute(
                path: AppRoutes.investments,
                builder: (context, state) => const InvestmentsScreen(),
                routes: [
                  GoRoute(
                    path: 'holding/:id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => HoldingDetailScreen(
                      holdingId: state.pathParameters['id'] ?? '',
                    ),
                  ),
                  GoRoute(
                    path: 'pension',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const PensionAssetsScreen(),
                  ),
                  GoRoute(
                    path: 'non-market-assets',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const NonMarketAssetsScreen(),
                  ),
                  GoRoute(
                    path: 'net-worth',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const NetWorthScreen(),
                  ),
                  GoRoute(
                    path: 'insights',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const InsightsScreen(),
                  ),
                ],
              ),
            ],
          ),

          // 5. Settings Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsHubScreen(),
                routes: [
                  GoRoute(
                    path: 'security',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const SecuritySettingsScreen(),
                  ),
                  GoRoute(
                    path: 'categories',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const CategoriesManagementScreen(),
                  ),
                  GoRoute(
                    path: 'accounts',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const AccountsListScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
