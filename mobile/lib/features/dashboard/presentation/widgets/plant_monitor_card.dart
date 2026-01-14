import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../domain/models/plant_status.dart';
import '../../presentation/widgets/liquid_progress_bar.dart';

class PlantMonitorCard extends StatefulWidget {
  final PlantStatus status;

  const PlantMonitorCard({super.key, required this.status});

  @override
  State<PlantMonitorCard> createState() => _PlantMonitorCardState();
}

class _PlantMonitorCardState extends State<PlantMonitorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color ringColor = _getHealthColor(widget.status.healthScore);

    return GlassContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top: Avatar & Header
          Stack(
            alignment: Alignment.center,
            children: [
              // Glowing Ring
              AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Container(
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
                          color: ringColor.withValues(
                            alpha: 0.4 + (0.2 * _glowAnimation.value),
                          ),
                          blurRadius: 20 + (10 * _glowAnimation.value),
                          spreadRadius: 5 + (5 * _glowAnimation.value),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Avatar
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black26,
                child: Icon(
                  Icons.eco,
                  size: 60,
                  color: Colors.white70,
                ), // Placeholder
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.status.name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.status.statusMessage,
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),

          // Middle: HUD Bars
          LiquidProgressBar(
            label: "Health Point",
            value: widget.status.healthScore / 100,
            baseColor: const Color(0xFF39FF14), // Nitrogen/Neon Green
          ),
          const SizedBox(height: 16),
          LiquidProgressBar(
            label: "Mana (Air)",
            value: widget.status.moistureLevel / 100,
            baseColor: Colors.cyanAccent,
          ),
          const SizedBox(height: 16),
          LiquidProgressBar(
            label: "Stamina (Cahaya)",
            value: widget.status.lightLevel / 100,
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
