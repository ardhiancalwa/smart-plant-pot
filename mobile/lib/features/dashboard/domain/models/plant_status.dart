class PlantStatus {
  final String name;
  final String avatarUrl; // Placeholder asset path or URL
  final double healthScore; // 0-100
  final double moistureLevel; // 0-100
  final double lightLevel; // 0-100
  final String statusMessage;

  const PlantStatus({
    required this.name,
    required this.avatarUrl,
    required this.healthScore,
    required this.moistureLevel,
    required this.lightLevel,
    required this.statusMessage,
  });
}
