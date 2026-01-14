import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../activity/presentation/screens/activity_screen.dart';
import '../../../education/presentation/screens/education_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class HomeNavNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}

final homeNavIndexProvider = NotifierProvider<HomeNavNotifier, int>(
  HomeNavNotifier.new,
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeNavIndexProvider);

    final screens = const [
      DashboardScreen(),
      ActivityScreen(),
      EducationScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true, // Important for glass effect over body
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      context,
                      ref,
                      index: 0,
                      icon: Icons.eco_outlined,
                      activeIcon: Icons.eco,
                      isSelected: currentIndex == 0,
                    ),
                    _buildNavItem(
                      context,
                      ref,
                      index: 1,
                      icon: Icons.list_alt_outlined,
                      activeIcon: Icons.list_alt,
                      isSelected: currentIndex == 1,
                    ),
                    _buildNavItem(
                      context,
                      ref,
                      index: 2,
                      icon: Icons.forum_outlined,
                      activeIcon: Icons.forum,
                      isSelected: currentIndex == 2,
                    ),
                    _buildNavItem(
                      context,
                      ref,
                      index: 3,
                      icon: Icons.person_outline,
                      activeIcon: Icons.person,
                      isSelected: currentIndex == 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    WidgetRef ref, {
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(homeNavIndexProvider.notifier).setIndex(index);
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF39FF14) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSelected ? activeIcon : icon,
          color: isSelected ? Colors.black : Colors.white70,
          size: 26,
        ),
      ),
    );
  }
}
