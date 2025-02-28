// models/doctor.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Doctor {
  final String id;
  final String name;
  final String specialization;
  final String imageUrl;
  final double rating;
  final double distance;
  final bool isVerified;
  final int reviews;
  final double matchPercentage;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.isVerified,
    required this.reviews,
    required this.matchPercentage,
  });
}

// providers/doctor_provider.dart

class DoctorProvider with ChangeNotifier {
  final List<Doctor> _doctors = [
    Doctor(
      id: '1',
      name: 'Dr. Phlox Gray',
      specialization: 'Orthopedic',
      imageUrl: 'lib/assets/Images/Ellipse 1.png', // Updated path
      rating: 4.5,
      distance: 1.6,
      isVerified: true,
      reviews: 125,
      matchPercentage: 93.57,
    ),
    Doctor(
      id: '2',
      name: 'Dr. Mogumin Black',
      specialization: 'Neurologist',
      imageUrl: 'lib/assets/Images/Ellipse 1.png', // Updated path
      rating: 4.1,
      distance: 2.1,
      isVerified: true,
      reviews: 89,
      matchPercentage: 87.32,
    ),
    Doctor(
      id: '3',
      name: 'Dr. Mogumin Black',
      specialization: 'Neurologist',
      imageUrl: 'lib/assets/Images/Ellipse 1.png', // Updated path
      rating: 4.1,
      distance: 2.1,
      isVerified: true,
      reviews: 89,
      matchPercentage: 87.32,
    ),
    // Add more doctors as needed
  ];

  List<Doctor> get doctors => [..._doctors];

  Doctor? get topMatch => _doctors.isNotEmpty
      ? _doctors.reduce((a, b) => a.matchPercentage > b.matchPercentage ? a : b)
      : null;

  List<Doctor> getDoctorsBySpecialization(String specialization) {
    return _doctors
        .where((doc) => doc.specialization == specialization)
        .toList();
  }

  void addDoctor(Doctor doctor) {
    _doctors.add(doctor);
    notifyListeners();
  }

  void updateDoctor(Doctor doctor) {
    final index = _doctors.indexWhere((d) => d.id == doctor.id);
    if (index >= 0) {
      _doctors[index] = doctor;
      notifyListeners();
    }
  }
}

// widgets/doctor_card.dart

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final bool showMatchPercentage;

  const DoctorCard({
    Key? key,
    required this.doctor,
    this.showMatchPercentage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              doctor.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (doctor.isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Colors.green, size: 16),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.local_hospital,
                        size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      doctor.specialization,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '${doctor.distance}km',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < doctor.rating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        size: 16,
                        color: Colors.amber,
                      );
                    }),
                    const SizedBox(width: 4),
                    Text(
                      doctor.rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' (${doctor.reviews})',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                if (showMatchPercentage) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'AI Match ${doctor.matchPercentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// screens/doctor_page.dart

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DoctorProvider(),
      child: const DoctorPageContent(),
    );
  }
}

class DoctorPageContent extends StatelessWidget {
  const DoctorPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildSpecializations(),
            _buildTopMatch(),
            _buildDoctorsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    // Your existing header implementation
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Browse All Doctors',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    // Your existing search bar implementation
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Near You',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializations() {
    final specializations = [
      {'title': 'Heart', 'color': Colors.purple, 'icon': Icons.favorite},
      {'title': 'Bone', 'color': Colors.green, 'icon': Icons.accessibility},
      {'title': 'Nutrition', 'color': Colors.red, 'icon': Icons.restaurant},
      {'title': 'Teeth', 'color': Colors.orange, 'icon': Icons.face},
      {
        'title': 'Disease',
        'color': Colors.blue,
        'icon': Icons.medical_services
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Browse by Specializations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: specializations.length,
            itemBuilder: (context, index) {
              final spec = specializations[index];
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (spec['color'] as Color).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        spec['icon'] as IconData,
                        color: spec['color'] as Color,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      spec['title'] as String,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopMatch() {
    return Consumer<DoctorProvider>(
      builder: (context, provider, _) {
        final topMatch = provider.topMatch;
        if (topMatch == null) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your AI Match',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DoctorCard(doctor: topMatch),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDoctorsList() {
    return Expanded(
      child: Consumer<DoctorProvider>(
        builder: (context, provider, _) {
          final doctors = provider.doctors;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              return DoctorCard(
                doctor: doctors[index],
                showMatchPercentage: false,
              );
            },
          );
        },
      ),
    );
  }
}
