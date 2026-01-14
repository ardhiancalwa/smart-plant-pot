import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/models/chat_session_model.dart';
import '../../../../core/theme/app_colors.dart';

class GlassChatBubble extends StatelessWidget {
  final ChatSessionModel message;

  const GlassChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isPlant = message.sender == 'plant';
    final glowColor = isPlant ? AppColors.primaryGreen : Colors.cyanAccent;
    final alignment = isPlant ? Alignment.centerLeft : Alignment.centerRight;
    final borderRadius = isPlant
        ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.zero,
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.zero,
            bottomLeft: Radius.circular(20),
          );

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isPlant) ...[
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                // Placeholder plant icon
                child: Icon(Icons.eco, color: AppColors.primaryGreen, size: 24),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: ClipRRect(
                borderRadius: borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: glowColor.withValues(alpha: 0.1),
                      borderRadius: borderRadius,
                      border: Border.all(
                        color: glowColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: glowColor.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.hasAudio)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.play_circle_fill,
                                  color: glowColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                // Dummy Waveform
                                Row(
                                  children: List.generate(5, (index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 1,
                                      ),
                                      width: 3,
                                      height: 10 + (index % 3) * 5.0,
                                      decoration: BoxDecoration(
                                        color: glowColor.withValues(alpha: 0.8),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDuration(
                                    message.audioDuration ?? Duration.zero,
                                  ),
                                  style: TextStyle(
                                    color: glowColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Text(
                          message.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTime(message.timestamp),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (!isPlant) ...[
              const SizedBox(width: 8),
              // Placeholder Child Avatar
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                child: Icon(Icons.face, color: Colors.cyanAccent, size: 24),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}
