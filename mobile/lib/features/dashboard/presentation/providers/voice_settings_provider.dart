import 'package:flutter_riverpod/flutter_riverpod.dart';

final voiceSettingsProvider = NotifierProvider<VoiceSettingsNotifier, bool>(() {
  return VoiceSettingsNotifier();
});

class VoiceSettingsNotifier extends Notifier<bool> {
  @override
  bool build() {
    return true; // Default value
  }

  void toggle() {
    state = !state;
  }
}
