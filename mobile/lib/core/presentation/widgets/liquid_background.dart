import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidBackground extends StatelessWidget {
  final Widget child;

  const LiquidBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Dark Background
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0A0E0B), // Deep dark background
          ),
        ),

        // 2. Neon Green Orb (Top Left)
        Positioned(
          top: -100,
          left: -100,
          child: _buildBlurredOrb(
            color: const Color(0xFF39FF14).withValues(alpha: 0.4),
            size: 400,
          ),
        ),

        // 3. Soft Blue Orb (Bottom Right)
        Positioned(
          bottom: -100,
          right: -50,
          child: _buildBlurredOrb(
            color: Colors.blueAccent.withValues(alpha: 0.3),
            size: 350,
          ),
        ),

        // 4. Center-ish faint glow
        Positioned(
          top: 300,
          left: 50,
          child: _buildBlurredOrb(
            color: const Color(0xFF39FF14).withValues(alpha: 0.1),
            size: 200,
          ),
        ),

        // 5. Content
        child,
      ],
    );
  }

  Widget _buildBlurredOrb({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 50.0, sigmaY: 50.0), // Heavy blur for "liquid" look
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
