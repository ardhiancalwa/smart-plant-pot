import 'package:flutter/material.dart';

class LiquidProgressBar extends StatelessWidget {
  final String label;
  final double value; // 0.0 to 1.0
  final Color baseColor;
  final String? valueText;

  const LiquidProgressBar({
    super.key,
    required this.label,
    required this.value,
    required this.baseColor,
    this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Text(
              valueText ?? '${(value * 100).toInt()}%',
              style: TextStyle(
                color: baseColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                shadows: [
                  Shadow(
                    color: baseColor.withValues(alpha: 0.6),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              // Inner shadow effect via slight overlay or just dark bg
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 4,
                offset: const Offset(0, 2),
                // inset: true (Flutter BoxShadow doesn't support inset directly easily without libraries, simulating with dark bg)
              ),
            ],
          ),
          child: Stack(
            children: [
              LayoutBuilder(builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth * value.clamp(0.0, 1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        baseColor.withValues(alpha: 0.6),
                        baseColor,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: baseColor.withValues(alpha: 0.6),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                );
              }),
              // Highlight reflection line on top
              Positioned(
                top: 2,
                left: 4,
                right: 4,
                height: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
