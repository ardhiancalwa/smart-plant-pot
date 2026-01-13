import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PlantAvatar extends StatelessWidget {
  final double health; // 0.0 to 1.0

  const PlantAvatar({
    super.key,
    required this.health,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: _getStatusColor(),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: _getStatusColor().withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          _getExpressionIcon(),
          size: 100,
          color: _getStatusColor(),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    if (health > 0.8) {
      return AppColors.primaryGreen; // Happy
    } else if (health < 0.4) {
      return AppColors.healthRed; // Critical/Sad
    } else {
      return AppColors.staminaYellow; // Neutral/Warning
    }
  }

  IconData _getExpressionIcon() {
    if (health > 0.8) {
      return Icons.sentiment_very_satisfied_rounded; // Happy
    } else if (health < 0.4) {
      return Icons.sentiment_very_dissatisfied_rounded; // Sad
    } else {
      return Icons.sentiment_neutral_rounded; // Neutral
    }
  }
}
