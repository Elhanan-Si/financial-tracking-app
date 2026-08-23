import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelpSettingsNotifier extends StateNotifier<bool> {
  HelpSettingsNotifier() : super(true);

  void toggle() {
    state = !state;
  }

  void setEnabled(bool enabled) {
    state = enabled;
  }
}

final helpTooltipsEnabledProvider = StateNotifierProvider<HelpSettingsNotifier, bool>((ref) {
  return HelpSettingsNotifier();
});
