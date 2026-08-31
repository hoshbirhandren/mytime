import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const WellnessTrackerApp());
}

// ============== MAIN APP ==============
class WellnessTrackerApp extends StatelessWidget {
  const WellnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Wellness Tracker',
        theme: ThemeData(
          primaryColor: Colors.green,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
// ============== USER PROVIDER  ==============

// ============== USER PROVIDER (Simplified) ==============
class UserProvider extends ChangeNotifier {
  String _userName = 'User';
  bool _isLoading = false;

  String get userName => _userName;
  bool get isLoading => _isLoading;

  UserProvider() {
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('userName') ?? 'User';
    notifyListeners();
  }

  void updateUserName(String newName) {
    _userName = newName;
    notifyListeners();
  }

  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    _userName = name;
    notifyListeners();
  }
}

// ============== SLEEP SCREEN ==============
class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  double _sleepHours = 7.0;
  DateTime _selectedDate = DateTime.now();
  String _sleepQuality = 'Good';
  TimeOfDay _bedTime = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 7, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Tracker'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF4A148C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.nightlight_round, color: Colors.white, size: 32),
                      const SizedBox(width: 12),
                      const Text(
                        'Sleep Tracker',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Track your sleep patterns for better health',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.green, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Sleep Duration',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, color: Colors.green),
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                if (_sleepHours > 0.25) _sleepHours -= 0.25;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Text(
                              _sleepHours.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const Text(
                              'hours',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.green),
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                if (_sleepHours < 12) _sleepHours += 0.25;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Slider(
                      value: _sleepHours,
                      min: 0.25,
                      max: 12,
                      divisions: 47,
                      activeColor: Colors.green,
                      label: _sleepHours.toStringAsFixed(2),
                      onChanged: (value) {
                        setState(() {
                          _sleepHours = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.bedtime, color: Colors.indigo, size: 24),
                          const SizedBox(height: 8),
                          const Text(
                            'Bed Time',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            _bedTime.format(context),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: _bedTime,
                                );
                                if (time != null) {
                                  setState(() {
                                    _bedTime = time;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo.shade50,
                                foregroundColor: Colors.indigo,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Set Time'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.sunny, color: Colors.orange, size: 24),
                          const SizedBox(height: 8),
                          const Text(
                            'Wake Time',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            _wakeTime.format(context),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: _wakeTime,
                                );
                                if (time != null) {
                                  setState(() {
                                    _wakeTime = time;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade50,
                                foregroundColor: Colors.orange,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Set Time'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.psychology, color: Colors.purple, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Sleep Quality',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildQualityButton('Poor', Icons.sentiment_very_dissatisfied, Colors.red),
                        _buildQualityButton('Fair', Icons.sentiment_dissatisfied, Colors.orange),
                        _buildQualityButton('Good', Icons.sentiment_satisfied, Colors.green),
                        _buildQualityButton('Excellent', Icons.sentiment_very_satisfied, Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.green, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.date_range, color: Colors.green, size: 30),
                      title: Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.green),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Sleep tracked: ${_sleepHours.toStringAsFixed(2)} hours - Quality: $_sleepQuality',
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  'Save Sleep Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityButton(String label, IconData icon, Color color) {
    final isSelected = _sleepQuality == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _sleepQuality = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey,
              size: 36,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============== READING TIME SCREEN ==============
class ReadingTimeScreen extends StatefulWidget {
  const ReadingTimeScreen({super.key});

  @override
  State<ReadingTimeScreen> createState() => _ReadingTimeScreenState();
}

class _ReadingTimeScreenState extends State<ReadingTimeScreen> {
  double _readingHours = 0.25;
  String _selectedBook = 'The Alchemist';
  DateTime _selectedDate = DateTime.now();
  int _pagesRead = 20;
  final List<String> _books = [
    'The Alchemist',
    'Atomic Habits',
    'The Power of Now',
    'Sapiens',
    'Deep Work',
    'The 7 Habits of Highly Effective People',
    'Think and Grow Rich',
    'The Subtle Art of Not Giving a F*ck',
    'Dune',
    '1984',
    'The Great Gatsby',
    'To Kill a Mockingbird',
    'Other...',
  ];

  String _formatHours(double hours) {
    int wholeHours = hours.floor();
    int minutes = ((hours - wholeHours) * 60).round();
    if (wholeHours == 0) {
      return '$minutes min';
    } else if (minutes == 0) {
      return '$wholeHours hr';
    } else {
      return '$wholeHours hr $minutes min';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Time'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE65100), Color(0xFFBF360C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.menu_book, color: Colors.white, size: 32),
                      const SizedBox(width: 12),
                      const Text(
                        'Reading Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Track your daily reading progress',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.orange, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Reading Duration (Hours)',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.orange, width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, color: Colors.orange),
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                if (_readingHours > 0.25) {
                                  _readingHours -= 0.25;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Text(
                              _readingHours.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              _formatHours(_readingHours),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.orange, width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.orange),
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                if (_readingHours < 12.0) {
                                  _readingHours += 0.25;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Slider(
                      value: _readingHours,
                      min: 0.25,
                      max: 12.0,
                      divisions: 47,
                      activeColor: Colors.orange,
                      label: _formatHours(_readingHours),
                      onChanged: (value) {
                        setState(() {
                          _readingHours = (value / 0.25).round() * 0.25;
                          if (_readingHours < 0.25) _readingHours = 0.25;
                          if (_readingHours > 12.0) _readingHours = 12.0;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0.25 hr',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '12 hrs',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.book, color: Colors.blue, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Pages Read',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, color: Colors.blue),
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                if (_pagesRead > 1) _pagesRead -= 1;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Text(
                              _pagesRead.toString(),
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const Text(
                              'pages',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.blue),
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                if (_pagesRead < 100) _pagesRead += 1;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Slider(
                      value: _pagesRead.toDouble(),
                      min: 1,
                      max: 100,
                      divisions: 99,
                      activeColor: Colors.blue,
                      label: '$_pagesRead pages',
                      onChanged: (value) {
                        setState(() {
                          _pagesRead = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.library_books, color: Colors.purple, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Book Selection',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedBook,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book, color: Colors.purple),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        items: _books.map((book) {
                          return DropdownMenuItem(
                            value: book,
                            child: Text(
                              book,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == 'Other...') {
                              _showCustomBookDialog();
                            } else {
                              _selectedBook = value!;
                            }
                          });
                        },
                      ),
                    ),
                    if (_selectedBook != 'Other...') ...[
                      const SizedBox(height: 8),
                      Text(
                        'Selected: $_selectedBook',
                        style: TextStyle(
                          color: Colors.purple.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.green, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.date_range, color: Colors.green, size: 30),
                      title: Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.green),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  String timeDisplay = _formatHours(_readingHours);
                  String bookDisplay = _selectedBook == 'Other...' ? 'Custom Book' : _selectedBook;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Reading tracked: $timeDisplay - $_pagesRead pages - Book: $bookDisplay',
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  'Save Reading Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showCustomBookDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Book Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Type your book name here...',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _selectedBook = 'The Alchemist';
                });
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    _selectedBook = controller.text;
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a book name'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add Book'),
            ),
          ],
        );
      },
    );
  }
}

// ============== PROFILE SCREEN ==============
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _studentName = '';
  String _college = '';
  String _stage = '';
  String _major = '';
  String _email = '';
  String _phone = '';
  String _dateOfBirth = '';
  String _bloodGroup = '';

  bool _isEditing = false;
  bool _isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _stageController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();

  final List<String> _collegeOptions = [
    'College of Pharmacy',
    'College of Medicine',
    'College of Dentistry',
    'College of Nursing',
    'College of Medical Science',
    'College of Engineering',
    'College of Business Administration',
    'College of Law',
    'College of Science',
    'College of Arts & Humanities',
    'College of Education',
    'College of Information Technology',
    'College of Architecture',
    'College of Agriculture',
  ];

  final List<String> _stageOptions = [
    '1st Year (Freshman)',
    '2nd Year (Sophomore)',
    '3rd Year (Junior)',
    '4th Year (Senior)',
    '5th Year',
    '6th year',
    'Graduate Student',
    'Postgraduate',
    'Msc',
    'PhD Candidate',
    'PhD',
  ];

  final List<String> _majorOptions = [
    'Pharmacy',
    'Medicine',
    'Dentistry',
    'Nursing',
    'Architecture',
    'Computer Science',
    'Software Engineering',
    'Electrical Engineering',
    'Mechanical Engineering',
    'Civil Engineering',
    'Chemical Engineering',
    'Business Management',
    'Marketing',
    'Finance',
    'Accounting',
    'Psychology',
    'Biology',
    'Chemistry',
    'Physics',
    'Mathematics',
    'English Literature',
    'History',
    'Political Science',
    'Economics',
  ];

  final List<String> _bloodGroupOptions = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();

      setState(() {
        _studentName = prefs.getString('studentName') ?? prefs.getString('userName') ?? 'Student';
        _college = prefs.getString('college') ?? '';
        _stage = prefs.getString('stage') ?? '';
        _major = prefs.getString('major') ?? '';
        _email = prefs.getString('userEmail') ?? '';
        _phone = prefs.getString('phone') ?? '';
        _dateOfBirth = prefs.getString('dateOfBirth') ?? '';
        _bloodGroup = prefs.getString('bloodGroup') ?? '';

        _nameController.text = _studentName;
        _collegeController.text = _college;
        _stageController.text = _stage;
        _majorController.text = _major;
        _emailController.text = _email;
        _phoneController.text = _phone;
        _dobController.text = _dateOfBirth;
        _bloodGroupController.text = _bloodGroup;

        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading profile: $e')),
      );
    }
  }

  Future<void> _saveProfileData() async {
    if (!_validateFields()) return;

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('studentName', _nameController.text.trim());
      await prefs.setString('userName', _nameController.text.trim());
      await prefs.setString('college', _collegeController.text.trim());
      await prefs.setString('stage', _stageController.text.trim());
      await prefs.setString('major', _majorController.text.trim());
      await prefs.setString('userEmail', _emailController.text.trim());
      await prefs.setString('phone', _phoneController.text.trim());
      await prefs.setString('dateOfBirth', _dobController.text.trim());
      await prefs.setString('bloodGroup', _bloodGroupController.text.trim());

      setState(() {
        _studentName = _nameController.text.trim();
        _college = _collegeController.text.trim();
        _stage = _stageController.text.trim();
        _major = _majorController.text.trim();
        _email = _emailController.text.trim();
        _phone = _phoneController.text.trim();
        _dateOfBirth = _dobController.text.trim();
        _bloodGroup = _bloodGroupController.text.trim();
        _isEditing = false;
        _isLoading = false;
      });

      final userProvider = context.read<UserProvider>();
      userProvider.updateUserName(_studentName);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully! ✅'),
          backgroundColor: Colors.green,
        ),
      );

    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profile: $e')),
      );
    }
  }

  bool _validateFields() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return false;
    }
    if (_emailController.text.trim().isNotEmpty &&
        !_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
      return false;
    }
    return true;
  }

  Widget _buildInfoTile(String label, String value, IconData icon, {Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? Colors.green, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isEmpty ? 'Not set' : value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: value.isEmpty ? FontWeight.normal : FontWeight.w500,
                    color: value.isEmpty ? Colors.grey.shade400 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          if (!_isEditing && value.isNotEmpty)
            Icon(Icons.check_circle, color: Colors.green, size: 18),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hintText,
    bool isDropdown = false,
    List<String>? dropdownItems,
    TextInputType? keyboardType,
    bool enabled = true,
    bool isRequired = false,
    String? suffixText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          if (isDropdown && dropdownItems != null)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: controller.text.isNotEmpty ? controller.text : null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.arrow_drop_down, color: Colors.green),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                items: dropdownItems.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: enabled ? (value) {
                  controller.text = value ?? '';
                } : null,
                hint: Text(hintText ?? 'Select $label'),
                isExpanded: true,
              ),
            )
          else
            TextFormField(
              controller: controller,
              enabled: enabled,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: Colors.green),
                suffixText: suffixText,
                hintText: hintText ?? 'Enter your $label',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),
                filled: true,
                fillColor: enabled ? Colors.white : Colors.grey.shade50,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              'Loading profile...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildEditToggle(),
            const SizedBox(height: 16),
            _buildStudentDetails(),
            const SizedBox(height: 16),
            _buildAcademicInfo(),
            const SizedBox(height: 16),
            _buildContactInfo(),
            const SizedBox(height: 16),
            _buildAdditionalInfo(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                _studentName.isNotEmpty ? _studentName[0].toUpperCase() : 'S',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _studentName.isEmpty ? 'Student' : _studentName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _college.isEmpty ? 'College not set' : _college,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeaderStat('📚', _major.isEmpty ? 'N/A' : _major.split(' ').first),
              const SizedBox(width: 20),
              _buildHeaderStat('📅', _stage.isEmpty ? 'N/A' : _stage.split(' ').first),
              const SizedBox(width: 20),
              _buildHeaderStat('🩸', _bloodGroup.isEmpty ? 'N/A' : _bloodGroup),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String emoji, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                _isEditing ? Icons.edit : Icons.visibility,
                color: _isEditing ? Colors.green : Colors.grey.shade600,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                _isEditing ? '✏️ Editing Mode' : '👁️ View Mode',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _isEditing ? Colors.green : Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Switch(
            value: _isEditing,
            onChanged: (value) {
              if (!value) {
                _loadProfileData();
              }
              setState(() {
                _isEditing = value;
              });
            },
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildStudentDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person_outline, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'Student Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          if (_isEditing) ...[
            _buildEditableField(
              label: 'Full Name',
              controller: _nameController,
              icon: Icons.person,
              hintText: 'Enter your full name',
              isRequired: true,
            ),
            _buildEditableField(
              label: 'Date of Birth',
              controller: _dobController,
              icon: Icons.calendar_today,
              hintText: 'DD/MM/YYYY',
            ),
            _buildEditableField(
              label: 'Blood Group',
              controller: _bloodGroupController,
              icon: Icons.bloodtype,
              isDropdown: true,
              dropdownItems: _bloodGroupOptions,
              hintText: 'Select blood group',
            ),
          ] else ...[
            _buildInfoTile('Full Name', _studentName, Icons.person),
            const SizedBox(height: 12),
            _buildInfoTile('Date of Birth', _dateOfBirth, Icons.calendar_today, iconColor: Colors.blue),
            const SizedBox(height: 12),
            _buildInfoTile('Blood Group', _bloodGroup, Icons.bloodtype, iconColor: Colors.red),
          ],
        ],
      ),
    );
  }

  Widget _buildAcademicInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.school, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'Academic Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          if (_isEditing) ...[
            _buildEditableField(
              label: 'College',
              controller: _collegeController,
              icon: Icons.business,
              isDropdown: true,
              dropdownItems: _collegeOptions,
              hintText: 'Select your college',
              isRequired: true,
            ),
            _buildEditableField(
              label: 'Academic Stage',
              controller: _stageController,
              icon: Icons.grade,
              isDropdown: true,
              dropdownItems: _stageOptions,
              hintText: 'Select your academic stage',
              isRequired: true,
            ),
            _buildEditableField(
              label: 'Major/Field of Study',
              controller: _majorController,
              icon: Icons.book,
              isDropdown: true,
              dropdownItems: _majorOptions,
              hintText: 'Select your major',
              isRequired: true,
            ),
          ] else ...[
            _buildInfoTile('College', _college, Icons.business),
            const SizedBox(height: 12),
            _buildInfoTile('Academic Stage', _stage, Icons.grade, iconColor: Colors.orange),
            const SizedBox(height: 12),
            _buildInfoTile('Major/Field of Study', _major, Icons.book, iconColor: Colors.purple),
          ],
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.contact_phone, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          if (_isEditing) ...[
            _buildEditableField(
              label: 'Email Address',
              controller: _emailController,
              icon: Icons.email,
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              isRequired: true,
            ),
            _buildEditableField(
              label: 'Phone Number',
              controller: _phoneController,
              icon: Icons.phone,
              hintText: 'Enter your phone number',
              keyboardType: TextInputType.phone,
            ),
          ] else ...[
            _buildInfoTile('Email', _email, Icons.email, iconColor: Colors.blue),
            const SizedBox(height: 12),
            _buildInfoTile('Phone', _phone, Icons.phone, iconColor: Colors.green),
            const SizedBox(height: 12),
          ],
          if (_isEditing) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfileData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Save Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'Quick Stats',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('📖', 'Reading', 'X min'),
              _buildStatCard('😴', 'Sleep', 'X hrs'),
              _buildStatCard('🏃', 'Exercise', 'X min'),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.green, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Complete wellness activities to earn badges and improve your stats!',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String emoji, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _collegeController.dispose();
    _stageController.dispose();
    _majorController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _bloodGroupController.dispose();
    super.dispose();
  }
}

// ============== HOME SCREEN ==============
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final userName = userProvider.userName;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Tracker'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildMonthlyRankingContent(context),
          _buildHomeContent(context, userName),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Monthly Rank',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, String userName) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(context, userName),
          const SizedBox(height: 20),
          _buildFeatureCard(
            context: context,
            icon: Icons.night_shelter,
            title: 'Sleep Tracker',
            subtitle: 'Track your sleep patterns',
            gradient: const LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF4A148C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SleepScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            context: context,
            icon: Icons.menu_book,
            title: 'Reading Time',
            subtitle: 'Track your daily reading',
            gradient: const LinearGradient(
              colors: [Color(0xFFE65100), Color(0xFFBF360C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReadingTimeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, String userName) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greeting,',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Stay healthy, stay happy! 🌟',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyRankingContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🏆 Monthly Ranking',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Top performers this month',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildRankingItem('🥇', 'Aram', '1st', Colors.amber.shade700, true),
                const Divider(height: 2),
                _buildRankingItem('🥈', 'Ibrahim', '2nd', Colors.grey.shade600, false),
                const Divider(height: 2),
                _buildRankingItem('🥉', 'Hoshbir', '3rd', Colors.brown.shade400, false),
                const Divider(height: 2),
                _buildRankingItem('4️⃣', 'NAME', '4th', Colors.blue.shade400, false),
                const Divider(height: 2),
                _buildRankingItem('5️⃣', 'NAME', '5th', Colors.purple.shade400, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingItem(String emoji, String name, String rank, Color color, bool isYou) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isYou ? FontWeight.bold : FontWeight.w500,
                    color: isYou ? Colors.green : Colors.black87,
                  ),
                ),
                if (isYou) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'You',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: isYou ? Border.all(color: Colors.green, width: 2) : null,
            ),
            child: Text(
              rank,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}