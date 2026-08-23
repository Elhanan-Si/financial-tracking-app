/// Route name and path constants for type-safe routing
abstract class AppRoutes {
  // Root Auth & Lock
  static const String lock = '/lock';

  // 5 Main Navigation Root Tabs
  static const String dashboard = '/dashboard';
  static const String transactions = '/transactions';
  static const String budgets = '/budgets';
  static const String investments = '/investments';
  static const String settings = '/settings';

  // Sub-routes and Modals
  static const String securitySettings = '/settings/security';
  static const String categoriesSettings = '/settings/categories';
  static const String backupSettings = '/settings/backup';
  static const String fastEntry = '/transactions/new';
  static const String transactionDetail = '/transactions/detail';
  static const String transfers = '/transfers';
  static const String recurring = '/recurring';
  static const String budgetPlanning = '/budgets/planning';
  static const String cashFlow = '/budgets/cash-flow';
  static const String creditCardForecast = '/budgets/credit-cards';
  static const String netWorth = '/investments/net-worth';
  static const String insights = '/investments/insights';
  static const String pensionAssets = '/investments/pension';
  static const String nonMarketAssets = '/investments/non-market-assets';
  static const String accounts = '/accounts';
  static const String importData = '/import';
  static const String importHistory = '/import/history';
  static const String uncategorizedTransactions = '/categories/uncategorized';
  static const String categoryRules = '/categories/rules';
}
