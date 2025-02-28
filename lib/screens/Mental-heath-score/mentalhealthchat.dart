import 'package:flutter/material.dart';
import 'package:lafia/screens/bottomnav/Bottom_Navigator.dart';
import 'package:table_calendar/table_calendar.dart';

class MentalHealth extends StatefulWidget {
  const MentalHealth({super.key});
  @override
  State<MentalHealth> createState() => _MentalHealthState();
}

enum Mood { superHappy, happy, neutral, sad, angry }

class MoodData {
  final Mood mood;
  final String? note;

  MoodData({required this.mood, this.note});
}

class _MentalHealthState extends State<MentalHealth> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, MoodData> _moodEvents = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // Initialize with sample data
    _moodEvents = {
      DateTime.now(): MoodData(mood: Mood.happy),
      DateTime.now().subtract(const Duration(days: 1)):
          MoodData(mood: Mood.neutral),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                       Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigator()),
                    ); 
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.brown),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.brown,
                      ),
                      child:
                          const Icon(Icons.question_mark, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title Section
                const Text(
                  'Freemind Score',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const Text(
                  'See your mental score insights',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),

                // Chart Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Chart Legend
                      Row(
                        children: [
                          _buildLegendItem("Positive", Colors.green.shade200),
                          const SizedBox(width: 16),
                          _buildLegendItem("Negative", Colors.orange),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16),
                                SizedBox(width: 4),
                                Text('Monthly'),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Calendar Widget
                      TableCalendar(
                        firstDay: DateTime.utc(2023, 1, 1),
                        lastDay: DateTime.utc(2025, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                          _showMoodSelectionDialog(selectedDay);
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Colors.brown.shade200,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: const BoxDecoration(
                            color: Colors.brown,
                            shape: BoxShape.circle,
                          ),
                          markerDecoration: BoxDecoration(
                            color: Colors.green.shade200,
                            shape: BoxShape.circle,
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) {
                            if (_moodEvents.containsKey(date)) {
                              return _buildMoodIndicator(
                                  _moodEvents[date]!.mood);
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Mood History Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Mood History',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _buildWeekMoodHistory(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildWeekMoodHistory() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final moods = [
      'lib/assets/Images/emotions/Emotionhappy.png',
      'lib/assets/Images/emotions/Emotionnuetral.png',
      'lib/assets/Images/emotions/Emotionsadd.png',
      'lib/assets/Images/emotions/Emotionhappy.png',
      'lib/assets/Images/emotions/Emotionangry.png',
      'lib/assets/Images/emotions/Emotionnuetral.png',
      'lib/assets/Images/emotions/Emotionsuper happy.png'
    ];

    return List.generate(
      7,
      (index) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              moods[index],
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            days[index],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodIndicator(Mood mood) {
    String assetPath;
    switch (mood) {
      case Mood.superHappy:
        assetPath = 'lib/assets/Images/emotions/Emotionsuper happy.png';
        break;
      case Mood.happy:
        assetPath = 'lib/assets/Images/emotions/Emotionhappy.png';
        break;
      case Mood.neutral:
        assetPath = 'lib/assets/Images/emotions/Emotionnuetral.png';
        break;
      case Mood.sad:
        assetPath = 'lib/assets/Images/emotions/Emotionsadd.png';
        break;
      case Mood.angry:
        assetPath = 'lib/assets/Images/emotions/Emotionangry.png';
        break;
    }

    return Center(
      child: Image.asset(
        assetPath,
        width: 24,
        height: 24,
      ),
    );
  }

  void _showMoodSelectionDialog(DateTime day) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('How are you feeling on ${day.toString().split(' ')[0]}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Image.asset(
                'lib/assets/Images/emotions/Emotionsuper happy.png',
                width: 24,
                height: 24,
              ),
              title: const Text('Super Happy'),
              onTap: () => _saveMood(day, Mood.superHappy),
            ),
            ListTile(
              leading: Image.asset(
                'lib/assets/Images/emotions/Emotionhappy.png',
                width: 24,
                height: 24,
              ),
              title: const Text('Happy'),
              onTap: () => _saveMood(day, Mood.happy),
            ),
            ListTile(
              leading: Image.asset(
                'lib/assets/Images/emotions/Emotionnuetral.png',
                width: 24,
                height: 24,
              ),
              title: const Text('Neutral'),
              onTap: () => _saveMood(day, Mood.neutral),
            ),
            ListTile(
              leading: Image.asset(
                'lib/assets/Images/emotions/Emotionsadd.png',
                width: 24,
                height: 24,
              ),
              title: const Text('Sad'),
              onTap: () => _saveMood(day, Mood.sad),
            ),
            ListTile(
              leading: Image.asset(
                'lib/assets/Images/emotions/Emotionangry.png',
                width: 24,
                height: 24,
              ),
              title: const Text('Angry'),
              onTap: () => _saveMood(day, Mood.angry),
            ),
          ],
        ),
      ),
    );
  }

  void _saveMood(DateTime day, Mood mood) {
    setState(() {
      _moodEvents[day] = MoodData(mood: mood);
    });
    Navigator.pop(context);
  }
}
