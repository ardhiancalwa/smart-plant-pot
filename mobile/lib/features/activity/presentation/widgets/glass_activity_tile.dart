import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../domain/models/activity_model.dart';
import '../../../../core/theme/app_colors.dart';

class GlassActivityTile extends StatelessWidget {
  final ActivityModel activity;
  final bool isLast;

  const GlassActivityTile({
    super.key,
    required this.activity,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    Color typeColor = _getTypeColor(activity.type);
    IconData typeIcon = _getTypeIcon(activity.type);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline logic
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: typeColor.withValues(alpha: 0.1),
                  border: Border.all(color: typeColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: typeColor.withValues(alpha: 0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(typeIcon, size: 20, color: typeColor),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [typeColor, typeColor.withValues(alpha: 0.1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: GlassContainer(
                borderRadius: 20,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activity.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _formatTime(activity.timestamp),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activity.description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: typeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        activity.actor,
                        style: TextStyle(
                          color: typeColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(ActivityType type) {
    switch (type) {
      case ActivityType.water:
        return AppColors.primaryGreen; // Neon Green
      case ActivityType.voice:
        return AppColors.manaBlue; // Blue
      case ActivityType.alert:
        return AppColors.healthRed; // Red
      case ActivityType.system:
        return AppColors.staminaYellow; // Yellow
    }
  }

  IconData _getTypeIcon(ActivityType type) {
    switch (type) {
      case ActivityType.water:
        return Icons.water_drop_rounded;
      case ActivityType.voice:
        return Icons.mic_rounded;
      case ActivityType.alert:
        return Icons.warning_rounded;
      case ActivityType.system:
        return Icons.star_rounded;
    }
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
