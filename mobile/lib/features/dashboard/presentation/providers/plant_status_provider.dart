import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/plant_status.dart';

final dummyPlantStatusProvider = Provider<PlantStatus>((ref) {
  return const PlantStatus(
    name: "Si Daun Bahagia",
    avatarUrl:
        "assets/images/plant_avatar_placeholder.png", // We'll handle this missing asset by using an Icon if load fails, or just use it as logic trigger
    healthScore: 85,
    moistureLevel: 45,
    lightLevel: 90,
    statusMessage: "Aku haus, tapi sehat!",
  );
});
