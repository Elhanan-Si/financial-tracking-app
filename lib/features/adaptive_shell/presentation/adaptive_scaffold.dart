import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_breakpoints.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';

/// Adaptive Scaffold supporting Responsive Breakpoints (Mobile BottomNav vs Desktop Right Sidebar)
class AdaptiveScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AdaptiveScaffold({
    super.key,
    required this.navigationShell,
  });

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < AppBreakpoints.compact;

    if (isCompact) {
      return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onDestinationSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(AppIcons.dashboard),
              label: 'דשבורד',
            ),
            NavigationDestination(
              icon: Icon(AppIcons.transactions),
              label: 'תנועות',
            ),
            NavigationDestination(
              icon: Icon(AppIcons.budgets),
              label: 'תקציב',
            ),
            NavigationDestination(
              icon: Icon(AppIcons.investments),
              label: 'השקעות',
            ),
            NavigationDestination(
              icon: Icon(AppIcons.settings),
              label: 'הגדרות',
            ),
          ],
        ),
      );
    }

    // Tablet & Desktop Layout: Right-aligned Navigation Sidebar (RTL)
    final isExpanded = width >= AppBreakpoints.expanded;

    return Scaffold(
      body: Row(
        textDirection: TextDirection.rtl, // RTL Sidebar on Right side
        children: [
          // Sidebar Container
          Container(
            width: isExpanded ? 240 : 88,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                left: BorderSide(color: AppColors.border, width: 1), // Border on the left of right sidebar
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.xl),
                // App Brand Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: AppSpacing.roundedMd,
                        ),
                        child: const Icon(AppIcons.bank, color: Colors.white, size: 20),
                      ),
                      if (isExpanded) ...[
                        const SizedBox(width: AppSpacing.md),
                        const Flexible(
                          child: Text(
                            'מעקב פיננסי',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Quick Action in Sidebar for Desktop
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Trigger quick action modal
                          showDialog(
                            context: context,
                            builder: (context) => const Dialog(
                              child: Padding(
                                padding: AppSpacing.modalPadding,
                                child: QuickActionFabContent(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(AppIcons.add, size: 18),
                        label: const Text('עסקה חדשה'),
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),

                // Navigation Rail Items
                Expanded(
                  child: NavigationRail(
                    extended: isExpanded,
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: _onDestinationSelected,
                    labelType: isExpanded ? NavigationRailLabelType.none : NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(AppIcons.dashboard),
                        label: Text('דשבורד'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(AppIcons.transactions),
                        label: Text('תנועות'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(AppIcons.budgets),
                        label: Text('תקציב'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(AppIcons.investments),
                        label: Text('השקעות'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(AppIcons.settings),
                        label: Text('הגדרות'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Screen Body
          Expanded(
            child: navigationShell,
          ),
        ],
      ),
    );
  }
}

/// Content wrapper for quick action dialog in Desktop mode
class QuickActionFabContent extends StatelessWidget {
  const QuickActionFabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'הזנת עסקה חדשה',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: const Icon(AppIcons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const TextField(
            autofocus: true,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.primary),
            decoration: InputDecoration(
              hintText: '0.00 ₪',
              labelText: 'סכום העסקה',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const TextField(
            decoration: InputDecoration(
              labelText: 'בית עסק / תיאור',
              prefixIcon: Icon(AppIcons.merchant),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('עסקה נשמרה בהצלחה'),
                    backgroundColor: AppColors.income,
                  ),
                );
              },
              child: const Text('שמור עסקה'),
            ),
          ),
        ],
      ),
    );
  }
}
