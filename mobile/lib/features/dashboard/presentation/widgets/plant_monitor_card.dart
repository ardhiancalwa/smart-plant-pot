import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../domain/models/plant_status.dart';
import '../../presentation/widgets/liquid_progress_bar.dart';

class PlantMonitorCard extends StatelessWidget {
  final PlantStatus status;

  const PlantMonitorCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color ringColor = _getHealthColor(status.healthScore);

    return GlassContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top: Avatar & Header
          Stack(
            alignment: Alignment.center,
            children: [
              // Glowing Ring
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ringColor.withValues(alpha: 0.6),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ringColor.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
              // Avatar
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black26,
                child: Icon(Icons.eco,
                    size: 60, color: Colors.white70), // Placeholder
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            status.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status.statusMessage,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),

          // Middle: HUD Bars
          LiquidProgressBar(
            label: "Health Point",
            value: status.healthScore / 100,
            baseColor: const Color(0xFF39FF14), // Nitrogen/Neon Green
          ),
          const SizedBox(height: 16),
          LiquidProgressBar(
            label: "Mana (Air)",
            value: status.moistureLevel / 100,
            baseColor: Colors.cyanAccent,
          ),
          const SizedBox(height: 16),
          LiquidProgressBar(
            label: "Stamina (Cahaya)",
            value: status.lightLevel / 100,
            baseColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  Color _getHealthColor(double score) {
    if (score > 80) return const Color(0xFF39FF14);
    if (score > 40) return Colors.yellowAccent;
    return Colors.redAccent;
  }
}
