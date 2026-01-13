import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/activity_model.dart';

final dummyActivityProvider = Provider<List<ActivityModel>>((ref) {
  final now = DateTime.now();
  return [
    ActivityModel(
      id: '1',
      timestamp: now.subtract(const Duration(minutes: 5)),
      type: ActivityType.water,
      title: "Mission Accomplished!",
      description: "Kakak watered the plant (+20 Mana).",
      actor: "Kakak",
    ),
    ActivityModel(
      id: '2',
      timestamp: now.subtract(const Duration(hours: 1)),
      type: ActivityType.voice,
      title: "Conversation",
      description: "Kakak asked: 'Why are your leaves yellow?'",
      actor: "Kakak",
    ),
    ActivityModel(
      id: '3',
      timestamp: now.subtract(const Duration(hours: 3)),
      type: ActivityType.alert,
      title: "Thirst Alert",
      description: "Pot requested water.",
      actor: "Pot",
    ),
    ActivityModel(
      id: '4',
      timestamp: now.subtract(const Duration(days: 1, hours: 2)),
      type: ActivityType.system,
      title: "Milestone Reached",
      description: "7 Days Streak keeping the plant happy!",
      actor: "System",
    ),
    ActivityModel(
      id: '5',
      timestamp: now.subtract(const Duration(days: 1, hours: 5)),
      type: ActivityType.water,
      title: "Morning Routine",
      description: "Kakak checked the stats.",
      actor: "Kakak",
    ),
  ];
});
