import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/chat_session_model.dart';

final dummyChatProvider = Provider<List<ChatSessionModel>>((ref) {
  final now = DateTime.now();
  return [
    ChatSessionModel(
      id: '1',
      sender: 'child',
      message: "Kenapa daunmu lemas?",
      timestamp: now.subtract(const Duration(minutes: 10)),
      hasAudio: true,
      audioDuration: const Duration(seconds: 4),
    ),
    ChatSessionModel(
      id: '2',
      sender: 'plant',
      message: "Aku kurang tenaga nih! Matahari sedang sembunyi hari ini.",
      timestamp: now.subtract(const Duration(minutes: 9, seconds: 45)),
    ),
    ChatSessionModel(
      id: '3',
      sender: 'child',
      message: "Kalau aku kasih lampu belajar, mau tidak?",
      timestamp: now.subtract(const Duration(minutes: 5)),
      hasAudio: true,
      audioDuration: const Duration(seconds: 5),
    ),
    ChatSessionModel(
      id: '4',
      sender: 'plant',
      message:
          "Wah, boleh juga! Itu bisa jadi stamina baruku. Terima kasih ya!",
      timestamp: now.subtract(const Duration(minutes: 4, seconds: 50)),
    ),
  ];
});
