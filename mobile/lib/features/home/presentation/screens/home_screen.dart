import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../activity/presentation/screens/activity_screen.dart';
import '../../../education/presentation/screens/education_screen.dart';

class HomeNavNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}

final homeNavIndexProvider =
    NotifierProvider<HomeNavNotifier, int>(HomeNavNotifier.new);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeNavIndexProvider);

    final screens = const [
      DashboardScreen(),
      ActivityScreen(),
      EducationScreen(),
    ];

    return Scaffold(
      extendBody: true, // Important for glass effect over body
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
          backgroundBlendMode: BlendMode.srcOver,
        ),
        child: ClipRRect(
          // borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), // Optional
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const TextStyle(
                        color: Color(0xFF39FF14), fontWeight: FontWeight.bold);
                  }
                  return const TextStyle(color: Colors.white70);
                }),
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const IconThemeData(
                        color: Colors.black); // Contrast on green
                  }
                  return const IconThemeData(color: Colors.white70);
                }),
                indicatorColor: const Color(0xFF39FF14), // Neon Green pill
                backgroundColor: Colors.transparent, // Transparent base
              ),
              child: NavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedIndex: currentIndex,
                onDestinationSelected: (index) {
                  ref.read(homeNavIndexProvider.notifier).setIndex(index);
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.dashboard_outlined),
                    selectedIcon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.list_alt_outlined),
                    selectedIcon: Icon(Icons.list_alt),
                    label: 'Activity',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.school_outlined),
                    selectedIcon: Icon(Icons.school),
                    label: 'Education',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
