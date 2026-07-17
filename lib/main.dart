import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this for opening the quiz link
import 'music_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    const ProviderScope(  // Only wrap once here
      child: CozyStudyApp(),
    ),
  );
}

class CozyStudyApp extends StatelessWidget {
  const CozyStudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cozy Study App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.brown,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0), // cozy warm beige
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Cozy Study ✨',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'The App that helps you get stuff done',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                  // we can add navigation later here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 140, 104),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Start Studying',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String quizUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfcYZddkn_bHBx9T0k9DwvzxDpY4uYX6UQtGPNUx44ak2YJ6Q/viewform?usp=dialog'; // Add your real link here

    Future<void> launchURL() async {
      final Uri url = Uri.parse(quizUrl);
      if (!await launchUrl(url)) {
        throw 'Could not launch $quizUrl';
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0),
      appBar: AppBar(
        title: const Text('Quiz Time!'),
        backgroundColor: const Color.fromARGB(255, 6, 140, 104),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Take this short quiz to find your perfect study schedule 📝",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: launchURL,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "Take the Quiz",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Already done?",
              style: TextStyle(fontSize: 16, color: Colors.brown),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StudyHomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 6, 140, 104),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "Ive taken the quiz. Lets study!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class StudyHomePage extends StatelessWidget {
  const StudyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (replace with your image path)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/study_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Top-left widget buttons
          Positioned(
            top: 40,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Calendar widget
                _buildFeatureButton(
                  icon: Icons.calendar_today,
                  label: 'Calendar',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CalendarPage()),
                    );

                    // Add calendar functionality later
                  },
                ),
                const SizedBox(height: 15),
                
                // To-Do List widget
                _buildFeatureButton(
                  icon: Icons.checklist,
                  label: 'To-Do',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TodoPage()),
                    );
                    // Add to-do functionality later
                  },
                ),
                const SizedBox(height: 15),
                
                // Music widget
                _buildFeatureButton(
                  icon: Icons.music_note,
                  label: 'Music',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MusicPage()),
                    );
                    // Add music functionality later
                  },
                ),
                const SizedBox(height: 15),
                
                // Timer widget
                _buildFeatureButton(
                  icon: Icons.timer,
                  label: 'Timer',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TimerPage()),
                    );

                    // Add timer functionality later
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withValues(),
        foregroundColor: Colors.brown[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
 class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  void _launchSpotify(String playlistId) async {
    final uri = Uri.parse('https://open.spotify.com/playlist/$playlistId');
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0), // Match your app's theme
      appBar: AppBar(
        title: const Text('Study Music'),
        backgroundColor: const Color.fromARGB(255, 6, 140, 104),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            _buildMusicCard(
              context,
              'White Noise',
              '2bRKxuH1o7pTmb1y4GfdEc', // Replace with your playlist ID
              Icons.waves,
              const Color(0xFFE1BEE7), // Pastel purple
            ),
            _buildMusicCard(
              context,
              'Brown Noise',
              '37i9dQZF1DX4ymr6UES7vc', 
              Icons.graphic_eq,
              const Color(0xFFD7CCC8), // Pastel brown
            ),
            _buildMusicCard(
              context,
              'Lo-Fi',
              '37i9dQZF1DWWQRwui0ExPn', 
              Icons.music_note,
              const Color(0xFFBBDEFB), // Pastel blue
            ),
            _buildMusicCard(
              context,
              'Rain Sounds',
              '37i9dQZF1DX8ymr6UES7vc', 
              Icons.cloudy_snowing,
              const Color(0xFFB2EBF2), // Pastel teal
            ),
            _buildMusicCard(
              context,
              'Classical',
              '37i9dQZF1DWWEJlAGA9gs0', 
              Icons.album,
              const Color(0xFFC8E6C9), // Pastel green
            ),
            _buildMusicCard(
              context,
              'Piano',
              '37i9dQZF1DX7K31D69s4M1', 
              Icons.piano,
              const Color(0xFFFFCDD2), // Pastel pink
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicCard(
    BuildContext context,
    String title,
    String playlistId,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: color.withValues(),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _launchSpotify(playlistId),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple[800]),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[800],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// -------------------- EVENT CLASS FOR CALENDAR --------------------
class Event {
  final String title;
  Event(this.title);

  @override
  String toString() => title;
}

// -------------------- CALENDAR PAGE --------------------
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final Map<DateTime, List<Event>> _events = {};
  final TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _eventController.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Event'),
        content: TextField(
          controller: _eventController,
          decoration: const InputDecoration(hintText: 'Event title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_eventController.text.isNotEmpty) {
                final eventDay = DateTime(
                  _selectedDay!.year,
                  _selectedDay!.month,
                  _selectedDay!.day,
                );
                setState(() {
                  _events[eventDay] = [
                    ..._events[eventDay] ?? [],
                    Event(_eventController.text),
                  ];
                  _selectedEvents.value = _getEventsForDay(eventDay);
                });
                _eventController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Calendar'),
        backgroundColor: const Color(0xFF6D4C41),
        leading: const BackButton(color: Colors.white),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, events, _) {
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(events[index].title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            final eventDay = DateTime(
                              _selectedDay!.year,
                              _selectedDay!.month,
                              _selectedDay!.day,
                            );
                            _events[eventDay]?.removeAt(index);
                            _selectedEvents.value = _getEventsForDay(eventDay);
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF6D4C41),
      ),
    );
  }
}

// -------------------- TIMER STATE + UI --------------------
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(TimerState.initial());
  Timer? _timer;

  void startTimer() {
    if (state.isRunning) return;
    state = state.copyWith(isRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.duration.inSeconds == 0) {
        stopTimer();
        return;
      }
      state = state.copyWith(
        duration: state.duration - const Duration(seconds: 1),
      );
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    state = state.copyWith(isRunning: false);
  }

  void resetTimer() {
    stopTimer();
    state = TimerState.initial();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class TimerState {
  final Duration duration;
  final bool isRunning;

  TimerState({required this.duration, required this.isRunning});

  factory TimerState.initial() => TimerState(
        duration: const Duration(minutes: 10),
        isRunning: false,
      );

  TimerState copyWith({Duration? duration, bool? isRunning}) {
    return TimerState(
      duration: duration ?? this.duration,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  String get formattedTime {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class TimerPage extends ConsumerWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider);
    final notifier = ref.read(timerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Timer'),
        backgroundColor: const Color(0xFF6D4C41),
        leading: const BackButton(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFFDF6F0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timer.formattedTime,
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: Colors.brown[800],
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _circleButton(
                  icon: timer.isRunning ? Icons.pause : Icons.play_arrow,
                  onPressed: () => timer.isRunning
                      ? notifier.stopTimer()
                      : notifier.startTimer(),
                  color: const Color(0xFF4CAF50),
                ),
                const SizedBox(width: 30),
                _circleButton(
                  icon: Icons.replay,
                  onPressed: notifier.resetTimer,
                  color: const Color(0xFFFF7043),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ClipOval(
      child: Material(
        color: color.withOpacity(0.15),
        child: InkWell(
          splashColor: color.withOpacity(0.25),
          onTap: onPressed,
          child: SizedBox(
            width: 70,
            height: 70,
            child: Icon(icon, size: 32, color: Colors.brown[800]),
          ),
        ),
      ),
    );
  }
}
// Models
class TodoItem {
  final String id;
  final String title;
  bool isDone;

  TodoItem({required this.id, required this.title, this.isDone = false});
}

class TodoList {
  final String name;
  final List<TodoItem> tasks;

  TodoList({required this.name, this.tasks = const []});
}

// Riverpod Providers
final todoListsProvider = StateNotifierProvider<TodoListNotifier, List<TodoList>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<TodoList>> {
  TodoListNotifier() : super([
    TodoList(name: "Default", tasks: []),
  ]);

  void addList(String name) {
    state = [...state, TodoList(name: name, tasks: [])];
  }

  void addTask(String listName, String taskTitle) {
    final listIndex = state.indexWhere((list) => list.name == listName);
    if (listIndex != -1) {
      final updatedList = state[listIndex];
      final newTask = TodoItem(id: const Uuid().v4(), title: taskTitle);
      final updatedTasks = [...updatedList.tasks, newTask];
      state = [
        ...state.sublist(0, listIndex),
        TodoList(name: updatedList.name, tasks: updatedTasks),
        ...state.sublist(listIndex + 1),
      ];
    }
  }

  void toggleTask(String listName, String taskId) {
    final listIndex = state.indexWhere((list) => list.name == listName);
    if (listIndex != -1) {
      final list = state[listIndex];
      final tasks = list.tasks.map((task) {
        if (task.id == taskId) {
          return TodoItem(id: task.id, title: task.title, isDone: !task.isDone);
        }
        return task;
      }).toList();
      state = [
        ...state.sublist(0, listIndex),
        TodoList(name: list.name, tasks: tasks),
        ...state.sublist(listIndex + 1),
      ];
    }
  }

  void removeTask(String listName, String taskId) {
    final listIndex = state.indexWhere((list) => list.name == listName);
    if (listIndex != -1) {
      final list = state[listIndex];
      final updatedTasks = list.tasks.where((task) => task.id != taskId).toList();
      state = [
        ...state.sublist(0, listIndex),
        TodoList(name: list.name, tasks: updatedTasks),
        ...state.sublist(listIndex + 1),
      ];
    }
  }
}

// UI
class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  String selectedList = "Default";
  final TextEditingController taskController = TextEditingController();
  final TextEditingController listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoLists = ref.watch(todoListsProvider);
    final currentList = todoLists.firstWhere((l) => l.name == selectedList, orElse: () => todoLists.first);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do Lists', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFFECECEC),
      ),
      backgroundColor: const Color(0xFFF7F6F2),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedList,
              items: todoLists.map((list) {
                return DropdownMenuItem(value: list.name, child: Text(list.name));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    selectedList = val;
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: listNameController,
                    decoration: InputDecoration(
                      hintText: 'New list name',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (listNameController.text.isNotEmpty) {
                      ref.read(todoListsProvider.notifier).addList(listNameController.text);
                      setState(() {
                        selectedList = listNameController.text;
                      });
                      listNameController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD6A9E2)),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: currentList.tasks.length,
                itemBuilder: (context, index) {
                  final task = currentList.tasks[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isDone ? TextDecoration.lineThrough : null,
                          color: task.isDone ? Colors.grey : Colors.black,
                        ),
                      ),
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: (_) {
                          ref.read(todoListsProvider.notifier).toggleTask(currentList.name, task.id);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          ref.read(todoListsProvider.notifier).removeTask(currentList.name, task.id);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      ref.read(todoListsProvider.notifier).addTask(currentList.name, taskController.text);
                      taskController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFABC4FF)),
                  child: const Icon(Icons.add_task),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}