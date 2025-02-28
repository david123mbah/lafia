
// providers/doctor_provider.dart
import 'package:flutter/material.dart';
import 'package:lafia/models/doctor.dart';


class DoctorProvider with ChangeNotifier {
  final List<Doctor> _doctors = [
    Doctor(
      id: '1',
      name: 'Dr. Phlox Gray',
      specialization: 'Orthopedic',
      imageUrl: 'lib/assets/Images/Ellipse 2.png',
      rating: 4.5,
      distance: 1.6,
      bio: 'A dedicated and compassionate medical professional with years of experience.',
      consultationFee: 97.99,
      hospitals: ['Green Hospital Center', 'Unity Hospital'],
      isAvailable: true,
      gender: 'Female',
    ),
    Doctor(
      id: '2',
      name: 'Dr. Hannibal Lecter',
      specialization: 'Psychiatrist',
      imageUrl: 'lib/assets/Images/Ellipse 2.png',
      rating: 4.1,
      distance: 2.3,
      bio: 'Experienced psychiatrist focused on patient care and mental health.',
      consultationFee: 97.99,
      hospitals: ['Serenity Medical Center', 'Metro Hospital'],
      isAvailable: true,
      gender: 'Male',
    ),
    // Add more dummy doctors...
  ];

  List<Doctor> get doctors => [..._doctors];

  List<Doctor> filterDoctors({
    String? gender,
    String? specialization,
    double? maxPrice,
  }) {
    return _doctors.where((doc) {
      bool matchesGender = gender == null || doc.gender == gender;
      bool matchesSpecialization = specialization == null || 
                                 doc.specialization == specialization;
      bool matchesPrice = maxPrice == null || doc.consultationFee <= maxPrice;
      return matchesGender && matchesSpecialization && matchesPrice;
    }).toList();
  }
}

