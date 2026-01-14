import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/glass_scaffold.dart';
import '../providers/chat_provider.dart';
import '../widgets/glass_chat_bubble.dart';
import '../widgets/live_monitor_bar.dart';
import '../widgets/topic_glass_card.dart';

class EducationScreen extends ConsumerWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatHistory = ref.watch(dummyChatProvider);

    return GlassScaffold(
      title: 'Education Log',
      body: Column(
        children: [
          // Spacer
          const SizedBox(height: 20),

          // Topic Card
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TopicGlassCard(topic: "Photosynthesis & Energy"),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                return GlassChatBubble(message: chatHistory[index]);
              },
            ),
          ),

          // Monitor Bar
          const LiveMonitorBar(),
          const SizedBox(height: 100), // Space for bottom nav
        ],
      ),
    );
  }
}
