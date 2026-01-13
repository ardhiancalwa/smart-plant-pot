enum ActivityType {
  water, // Care
  voice, // Chat
  alert, // Critical
  system // Milestone/System
}

class ActivityModel {
  final String id;
  final DateTime timestamp;
  final ActivityType type;
  final String title;
  final String description;
  final String actor; // e.g., "Kakak", "System", "Pot"

  const ActivityModel({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.title,
    required this.description,
    required this.actor,
  });
}
