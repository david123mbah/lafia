import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lafia/utils/colors.dart';
import 'package:lafia/widgets/custom_button.dart';

import '../../routes/approutes.dart';

// Models
enum PhysicalDistress { veryPainful, noPain, slightPain }

enum SleepQuality { excellent, good, fair, poor, worst }

enum MedicationType { prescribed, overCounter, none, preferNotSay }

class AssessmentAnswers {
  bool? soughtProfessionalHelp;
  PhysicalDistress? physicalDistress;
  SleepQuality? sleepQuality;
  List<MedicationType> medications = [];
  int stressLevel = 0;
  String expressionAnalysis = '';
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final AssessmentAnswers _answers = AssessmentAnswers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _ProfessionalHelpPage(
              onContinue: (value) {
                _answers.soughtProfessionalHelp = value;
                _nextPage();
              },
            ),
            _PhysicalDistressPage(
              onContinue: (value) {
                _answers.physicalDistress = value;
                _nextPage();
              },
            ),
            _SleepQualityPage(
              onContinue: (value) {
                _answers.sleepQuality = value;
                Future.delayed(const Duration(seconds: 2), _nextPage);
              },
            ),
            _MedicationsPage(
              onContinue: (value) {
                _answers.medications = value;
                _nextPage();
              },
            ),
            _StressLevelPage(
              onContinue: (value) {
                _answers.stressLevel = value;
                Future.delayed(const Duration(seconds: 5), _nextPage);
              },
            ),
            _ExpressionAnalysisPage(
              onContinue: (value) {
                _answers.expressionAnalysis = value;
                // Handle completion
              },
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

// Common Widgets
class _PageHeader extends StatelessWidget {
  final String currentPage;
  final String totalPages;

  const _PageHeader({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Handle back navigation
              Navigator.of(context).maybePop();
            },
            child: Image.asset(
              'lib/assets/Images/profileIcons/backicons.png', // Ensure this points to your back arrow image
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Assessment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            '$currentPage of $totalPages',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

class _TimelineIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _TimelineIndicator({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep - 1;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? const Color(0xFF7D944D)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    ).animate().fadeIn();
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ContinueButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7D944D),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5);
  }
}

class _OptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final bool bordered;

  const _OptionButton({
    required this.text,
    required this.onTap,
    required this.color,
    this.textColor = Colors.white,
    this.bordered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: bordered ? 0 : 2,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: bordered
                ? BorderSide(color: const Color(0xFF7D944D), width: 2)
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Individual Pages
class _ProfessionalHelpPage extends StatelessWidget {
  final Function(bool) onContinue;

  const _ProfessionalHelpPage({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _PageHeader(currentPage: '1', totalPages: '6'),
        const _TimelineIndicator(currentStep: 1, totalSteps: 6),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'lib/assets/Images/mindicons/Group.png',
                      height: MediaQuery.of(context).size.height * 0.3,
                    ).animate().fadeIn().scale(),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Have you sought professional help before?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideX(),
                  const SizedBox(height: 40),
                  _OptionButton(
                    text: 'Yes',
                    onTap: () => onContinue(true),
                    color: const Color(0xFF7D944D),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 16),
                  _OptionButton(
                    text: 'No',
                    onTap: () => onContinue(false),
                    color: Colors.white,
                    textColor: const Color(0xFF7D944D),
                    bordered: true,
                  ).animate().fadeIn(delay: 400.ms),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Add this new widget for the timeline slider
class _TimelineSlider extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final Function(int) onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const _TimelineSlider({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    this.activeColor = const Color(0xFF7D944D),
    this.inactiveColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              // Timeline line
              Positioned(
                top: 25,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  color: inactiveColor,
                ),
              ),
              // Timeline points
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  labels.length,
                  (index) => GestureDetector(
                    onTap: () => onChanged(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index <= selectedIndex
                                ? activeColor
                                : inactiveColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          labels[index],
                          style: TextStyle(
                            color: index <= selectedIndex
                                ? activeColor
                                : Colors.grey,
                            fontSize: 12,
                            fontWeight: index == selectedIndex
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (100 * index).ms),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Update the _PhysicalDistressPage
class _PhysicalDistressPage extends StatefulWidget {
  final Function(PhysicalDistress) onContinue;

  const _PhysicalDistressPage({required this.onContinue});

  @override
  State<_PhysicalDistressPage> createState() => _PhysicalDistressPageState();
}

class _PhysicalDistressPageState extends State<_PhysicalDistressPage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _PageHeader(currentPage: '2', totalPages: '6'),
        const _TimelineIndicator(currentStep: 2, totalSteps: 6),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Are you experiencing any physical symptoms of distress?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ).animate().fadeIn().slideX(),
                  const SizedBox(height: 40),
                  _TimelineSlider(
                    labels: const ['Very Painful', 'Slight Pain', 'No Pain'],
                    selectedIndex: selectedIndex,
                    onChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  _ContinueButton(
                    onTap: () {
                      final distress = [
                        PhysicalDistress.veryPainful,
                        PhysicalDistress.slightPain,
                        PhysicalDistress.noPain,
                      ][selectedIndex];
                      widget.onContinue(distress);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Update the _SleepQualityPage
class _SleepQualityPage extends StatefulWidget {
  final Function(SleepQuality) onContinue;

  const _SleepQualityPage({required this.onContinue});

  @override
  State<_SleepQualityPage> createState() => _SleepQualityPageState();
}

class _SleepQualityPageState extends State<_SleepQualityPage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _PageHeader(currentPage: '3', totalPages: '6'),
        const _TimelineIndicator(currentStep: 3, totalSteps: 6),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How would you rate your sleep quality?',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().slideX(),
                  const SizedBox(height: 40),
                  _TimelineSlider(
                    labels: const [
                      'Excellent',
                      'Good',
                      'Fair',
                      'Poor',
                      'Worst'
                    ],
                    selectedIndex: selectedIndex,
                    onChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  _ContinueButton(
                    onTap: () {
                      final quality = SleepQuality.values[selectedIndex];
                      widget.onContinue(quality);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MedicationsPage extends StatefulWidget {
  final Function(List<MedicationType>) onContinue;

  const _MedicationsPage({required this.onContinue});

  @override
  State<_MedicationsPage> createState() => _MedicationsPageState();
}

class _MedicationsPageState extends State<_MedicationsPage> {
  final Set<MedicationType> _selectedMedications = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _PageHeader(currentPage: '4', totalPages: '6'),
        const _TimelineIndicator(currentStep: 4, totalSteps: 6),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Are you taking any medications or supplements?',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().slideX(),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: MedicationType.values.map((type) {
                      return _MedicationChip(
                        type: type,
                        isSelected: _selectedMedications.contains(type),
                        onToggle: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedMedications.add(type);
                            } else {
                              _selectedMedications.remove(type);
                            }
                          });
                        },
                      ).animate().fadeIn(delay: 200.ms);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        _ContinueButton(
          onTap: () => widget.onContinue(_selectedMedications.toList()),
        ),
      ],
    );
  }
}

class _StressLevelPage extends StatelessWidget {
  final Function(int) onContinue;

  const _StressLevelPage({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _PageHeader(currentPage: '5', totalPages: '6'),
        const _TimelineIndicator(currentStep: 5, totalSteps: 6),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'How would you rate your stress level?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().slideX(),
                  const SizedBox(height: 40),
                  Text(
                    '5',
                    style: Theme.of(context).textTheme.displayLarge,
                  ).animate().fadeIn(delay: 200.ms).scale(),
                  const SizedBox(height: 24),
                  _StressLevelIndicator(
                    onSelected: (level) => onContinue(level),
                  ).animate().fadeIn(delay: 300.ms),
                  const Text(
                    'You Are Extremely Stressed Out.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Define the _StressLevelIndicator widget
class _StressLevelIndicator extends StatefulWidget {
  final Function(int) onSelected;

  const _StressLevelIndicator({required this.onSelected});

  @override
  State<_StressLevelIndicator> createState() => _StressLevelIndicatorState();
}

class _StressLevelIndicatorState extends State<_StressLevelIndicator> {
  int _currentLevel = 5;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentLevel.toDouble(),
      min: 0,
      max: 10,
      divisions: 10,
      label: '$_currentLevel',
      onChanged: (value) {
        setState(() {
          _currentLevel = value.toInt();
        });
        widget.onSelected(_currentLevel);
      },
    );
  }
}

class _ExpressionAnalysisPage extends StatefulWidget {
  final Function(String) onContinue;

  const _ExpressionAnalysisPage({required this.onContinue});

  @override
  State<_ExpressionAnalysisPage> createState() =>
      _ExpressionAnalysisPageState();
}

class _ExpressionAnalysisPageState extends State<_ExpressionAnalysisPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showCompletionPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 400,
            height: 400,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/Images/mindicons/dd.png',
                  height: 150,
                  width: double.infinity,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Find your inner peace ,Healing mind, body, and soul',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.toNamed(TRoutes.BottomNav);
                  },
                  text: 'Continue',
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _PageHeader(currentPage: '6', totalPages: '6'),
        const _TimelineIndicator(currentStep: 6, totalSteps: 6),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expression Analysis',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().slideX(),
                  const Text(
                    'Freely write down anything that\'s on your mind. Dr.Pravda is here to listen.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Start typing...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.mic, color: Color(0xFF4A332D)),
                      SizedBox(width: 8),
                    ],
                  ).animate().fadeIn(delay: 400.ms),
                ],
              ),
            ),
          ),
        ),
        _ContinueButton(
          onTap: () {
            widget.onContinue(_controller.text);
            _showCompletionPopup();
          },
        ),
      ],
    );
  }
}

class _MedicationChip extends StatelessWidget {
  final MedicationType type;
  final bool isSelected;
  final Function(bool) onToggle;

  const _MedicationChip({
    required this.type,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(type.toString().split('.').last),
      selected: isSelected,
      onSelected: onToggle,
      selectedColor: const Color(0xFF9BB98B),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }
}
