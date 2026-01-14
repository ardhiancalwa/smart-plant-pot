import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'liquid_background.dart';

class GlassScaffold extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget body;
  final bool centerTitle;

  const GlassScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: LiquidBackground(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: centerTitle,
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                actions: actions,
              ),
            ];
          },
          body: body,
        ),
      ),
    );
  }
}
