class ChatSessionModel {
  final String id;
  final String sender; // 'plant' or 'child'
  final String message;
  final DateTime timestamp;
  final bool hasAudio;
  final Duration? audioDuration;

  const ChatSessionModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
    this.hasAudio = false,
    this.audioDuration,
  });
}
