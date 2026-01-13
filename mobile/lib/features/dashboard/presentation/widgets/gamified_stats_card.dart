import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class GamifiedStatsCard extends StatelessWidget {
  final double mana; // 0.0 to 1.0 (Humidity)
  final double stamina; // 0.0 to 1.0 (Temp/Light)
  final double health; // 0.0 to 1.0 (Overall status)

  const GamifiedStatsCard({
    super.key,
    required this.mana,
    required this.stamina,
    required this.health,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Plant Status',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildStatRow(context, 'Mana (Water)', mana, AppColors.manaBlue),
            const SizedBox(height: 12),
            _buildStatRow(context, 'Stamina (Light/Temp)', stamina,
                AppColors.staminaYellow),
            const SizedBox(height: 12),
            _buildStatRow(
                context, 'Health (Overall)', health, AppColors.healthRed),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
      BuildContext context, String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: value),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic,
          builder: (context, val, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: val,
                backgroundColor: color.withValues(alpha: 0.2),
                color: color,
                minHeight: 12,
              ),
            );
          },
        ),
      ],
    );
  }
}
