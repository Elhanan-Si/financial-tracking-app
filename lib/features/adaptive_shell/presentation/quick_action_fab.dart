import 'package:flutter/material.dart';
import '../../../core/constants/app_icons.dart';
import '../../transactions/presentation/screens/fast_entry_modal.dart';

/// Floating Action Button for fast transaction recording
class QuickActionFab extends StatelessWidget {
  const QuickActionFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'quick_action_fab',
      onPressed: () => FastEntryModal.show(context),
      tooltip: 'הזנת עסקה חדשה',
      child: const Icon(AppIcons.add, size: 28),
    );
  }
}
