
// models/doctor.dart
class Doctor {
  final String id;
  final String name;
  final String specialization;
  final String imageUrl;
  final double rating;
  final double distance;
  final String bio;
  final double consultationFee;
  final List<String> hospitals;
  final bool isAvailable;
  final String gender;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.bio,
    required this.consultationFee,
    required this.hospitals,
    required this.isAvailable,
    required this.gender,
  });
}
