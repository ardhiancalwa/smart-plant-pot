import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/liquid_background.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../presentation/providers/plant_status_provider.dart';
import '../../presentation/providers/voice_settings_provider.dart';
import '../../presentation/widgets/plant_monitor_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantStatus = ref.watch(dummyPlantStatusProvider);
    final isVoiceOn = ref.watch(voiceSettingsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Smart Guardian'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        actions: [
          // Voice Toggle
          IconButton(
            onPressed: () {
              ref.read(voiceSettingsProvider.notifier).toggle();
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isVoiceOn
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isVoiceOn
                        ? Colors.blueAccent.withValues(alpha: 0.3)
                        : Colors.transparent,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                isVoiceOn ? Icons.mic : Icons.mic_off,
                color: isVoiceOn ? Colors.white : Colors.white70,
                size: 20,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_none, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=5',
            ), // Dummy User
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: LiquidBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            120,
            16,
            30,
          ), // Top padding for AppBar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Halo, Parents!",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Pantau Si Kecil & Tanaman",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              // Main Monitor Card
              PlantMonitorCard(status: plantStatus),

              const SizedBox(height: 24),

              // Recent Activity Section
              const Text(
                "Recent Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              GlassContainer(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.water_drop,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Watered by Kakak",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Today, 08:30 AM",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
