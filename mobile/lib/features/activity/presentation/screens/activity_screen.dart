import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/glass_scaffold.dart';
import '../../domain/models/activity_model.dart';
import '../providers/activity_provider.dart';
import '../widgets/glass_activity_tile.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(dummyActivityProvider);
    final groupedActivities = _groupActivitiesByDate(activities);

    return GlassScaffold(
      title: 'Activity Log',
      body: groupedActivities.isEmpty
          ? const Center(
              child: Text(
                'No Activities',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
              itemCount: groupedActivities.keys.length,
              itemBuilder: (context, index) {
                final date = groupedActivities.keys.elementAt(index);
                final items = groupedActivities[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    ...items.map((activity) {
                      final isLastInGroup = activity == items.last;
                      return GlassActivityTile(
                        activity: activity,
                        isLast: isLastInGroup,
                      );
                    }),
                  ],
                );
              },
            ),
    );
  }

  Map<String, List<ActivityModel>> _groupActivitiesByDate(
    List<ActivityModel> activities,
  ) {
    Map<String, List<ActivityModel>> groups = {};
    for (var activity in activities) {
      final dateKey = _getDateLabel(activity.timestamp);
      if (!groups.containsKey(dateKey)) {
        groups[dateKey] = [];
      }
      groups[dateKey]!.add(activity);
    }
    return groups;
  }

  String _getDateLabel(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (date == today) {
      return "Today";
    } else if (date == yesterday) {
      return "Yesterday";
    } else {
      return "${timestamp.day}/${timestamp.month}/${timestamp.year}";
    }
  }
}
