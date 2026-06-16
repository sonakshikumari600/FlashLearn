import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/flashcard.dart';
import 'services/profile_service.dart';
import 'screens/splash_screen.dart';
import 'screens/deck_management_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatefulWidget {
  const FlashcardApp({super.key});

  @override
  State<FlashcardApp> createState() => _FlashcardAppState();
}

class _FlashcardAppState extends State<FlashcardApp> {
  final ProfileService _profileService = ProfileService.instance;

  @override
  void initState() {
    super.initState();
    _profileService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B5CF6)),
        useMaterial3: true,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: Builder(
        builder: (context) => SplashScreenWrapper(
          profileService: _profileService,
        ),
      ),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  final ProfileService profileService;

  const SplashScreenWrapper({
    super.key,
    required this.profileService,
  });

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => DeckManagementScreen(
              profileService: widget.profileService,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class FlashcardHome extends StatefulWidget {
  final ProfileService profileService;

  const FlashcardHome({
    super.key,
    required this.profileService,
  });

  @override
  State<FlashcardHome> createState() => _FlashcardHomeState();
}

class _FlashcardHomeState extends State<FlashcardHome> {
  List<Flashcard> flashcards = [
    Flashcard(
      question: "What is Flutter?",
      answer: "Flutter is an open-source UI toolkit by Google.",
    ),
    Flashcard(
      question: "Which programming language is used in Flutter?",
      answer: "Dart",
    ),
    Flashcard(
      question: "What is a StatefulWidget?",
      answer: "A widget that can change its state during runtime.",
    ),
    Flashcard(
      question: "What is a StatelessWidget?",
      answer: "A widget whose state cannot change after creation.",
    ),
    Flashcard(
      question: "What command creates a Flutter project?",
      answer: "flutter create project_name",
    ),
    Flashcard(
      question: "What widget is used for vertical layouts?",
      answer: "Column",
    ),
    Flashcard(
      question: "What widget is used for horizontal layouts?",
      answer: "Row",
    ),
    Flashcard(
      question: "What is Hot Reload?",
      answer: "A feature that updates code changes instantly without restarting the app.",
    ),
    Flashcard(
      question: "Which widget adds spacing between widgets?",
      answer: "SizedBox",
    ),
    Flashcard(
      question: "What widget provides app structure in Flutter?",
      answer: "Scaffold",
    ),
    Flashcard(
      question: "What does setState() do?",
      answer: "It rebuilds the UI when state changes.",
    ),
    Flashcard(
      question: "What widget displays text?",
      answer: "Text widget",
    ),
    Flashcard(
      question: "What widget is used for lists?",
      answer: "ListView",
    ),
    Flashcard(
      question: "What package manages local storage simply?",
      answer: "shared_preferences",
    ),
    Flashcard(
      question: "What is pubspec.yaml used for?",
      answer: "Managing dependencies and project configuration.",
    ),
  ];

  int currentIndex = 0;
  bool showAnswer = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _nextCard() {
    if (currentIndex < flashcards.length - 1) {
      widget.profileService.addScore(1);
      setState(() {
        currentIndex++;
        showAnswer = false;
      });
    }
  }

  void _previousCard() {
    if (currentIndex > 0) {
      widget.profileService.addScore(1);
      setState(() {
        currentIndex--;
        showAnswer = false;
      });
    }
  }

  void _toggleAnswer() {
    widget.profileService.addScore(2);
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Flashcard Quiz',
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFF8B5CF6)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    profileService: widget.profileService,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.folder_outlined, color: Color(0xFF8B5CF6)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeckManagementScreen(
                    profileService: widget.profileService,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.list_rounded, color: Color(0xFF8B5CF6)),
            onPressed: _showManageFlashcards,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: flashcards.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.style_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'No flashcards yet',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first flashcard',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA78BFA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.quiz_outlined, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '${currentIndex + 1}/${flashcards.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            const Color(0xFFF3E8FF).withOpacity(0.6),
                            Colors.white,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA78BFA).withOpacity(0.12),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (showAnswer)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 40),
                                ),
                              if (showAnswer) const SizedBox(height: 20),
                              Text(
                                showAnswer ? 'Answer' : 'Question',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: showAnswer ? const Color(0xFF10B981) : const Color(0xFF8B5CF6),
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    showAnswer ? flashcards[currentIndex].answer : flashcards[currentIndex].question,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA78BFA),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFA78BFA).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _toggleAnswer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        showAnswer ? 'Hide Answer' : 'Show Answer',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: currentIndex > 0 ? _previousCard : null,
                            icon: const Icon(Icons.arrow_back_rounded),
                            label: const Text('Previous'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF8B5CF6),
                              disabledBackgroundColor: Colors.grey.shade100,
                              disabledForegroundColor: Colors.grey.shade400,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: currentIndex < flashcards.length - 1 ? _nextCard : null,
                            icon: const Icon(Icons.arrow_forward_rounded),
                            label: const Text('Next'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF8B5CF6),
                              disabledBackgroundColor: Colors.grey.shade100,
                              disabledForegroundColor: Colors.grey.shade400,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _showEditDialog(currentIndex),
                        icon: const Icon(Icons.edit_outlined),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF8B5CF6),
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () => _showDeleteDialog(currentIndex),
                        icon: const Icon(Icons.delete_outline),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _showAddDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 32),
        ),
      ),
    );
  }

  void _showManageFlashcards() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlashcardListScreen(
          profileService: widget.profileService,
          flashcards: flashcards,
          onEdit: _showEditDialog,
          onDelete: _showDeleteDialog,
          onAdd: _showAddDialog,
        ),
      ),
    );
  }

  void _showAddDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFlashcardScreen(
          profileService: widget.profileService,
          onAdd: (question, answer) {
            setState(() {
              flashcards.add(Flashcard(question: question, answer: answer));
            });
            widget.profileService.addScore(5);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showEditDialog(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFlashcardScreen(
          profileService: widget.profileService,
          flashcard: flashcards[index],
          onSave: (question, answer) {
            setState(() {
              flashcards[index].question = question;
              flashcards[index].answer = answer;
            });
            widget.profileService.addScore(3);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.warning_rounded, color: Colors.red.shade400, size: 48),
              ),
              const SizedBox(height: 20),
              const Text(
                'Delete Flashcard?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'This action cannot be undone.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flashcards.removeAt(index);
                          if (currentIndex >= flashcards.length && flashcards.isNotEmpty) {
                            currentIndex = flashcards.length - 1;
                          } else if (flashcards.isEmpty) {
                            currentIndex = 0;
                          }
                          showAnswer = false;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddFlashcardScreen extends StatefulWidget {
  final ProfileService profileService;
  final Function(String, String) onAdd;

  const AddFlashcardScreen({
    super.key,
    required this.profileService,
    required this.onAdd,
  });

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Flashcard',
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (questionController.text.isNotEmpty && answerController.text.isNotEmpty) {
                widget.onAdd(questionController.text, answerController.text);
                widget.profileService.addScore(5);
                Navigator.pop(context);
              }
            },
            child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Question',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: questionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter your question here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Answer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: answerController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Enter the answer here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditFlashcardScreen extends StatefulWidget {
  final ProfileService profileService;
  final Flashcard flashcard;
  final Function(String, String) onSave;

  const EditFlashcardScreen({
    super.key,
    required this.profileService,
    required this.flashcard,
    required this.onSave,
  });

  @override
  State<EditFlashcardScreen> createState() => _EditFlashcardScreenState();
}

class _EditFlashcardScreenState extends State<EditFlashcardScreen> {
  late TextEditingController questionController;
  late TextEditingController answerController;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController(text: widget.flashcard.question);
    answerController = TextEditingController(text: widget.flashcard.answer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Flashcard',
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (questionController.text.isNotEmpty && answerController.text.isNotEmpty) {
                widget.onSave(questionController.text, answerController.text);
                widget.profileService.addScore(3);
                Navigator.pop(context);
              }
            },
            child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Question',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: questionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter your question here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Answer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: answerController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Enter the answer here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlashcardListScreen extends StatelessWidget {
  final ProfileService profileService;
  final List<Flashcard> flashcards;
  final Function(int) onEdit;
  final Function(int) onDelete;
  final VoidCallback onAdd;

  const FlashcardListScreen({
    super.key,
    required this.profileService,
    required this.flashcards,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Flashcards',
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFF8B5CF6)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    profileService: profileService,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                flashcards[index].question,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  flashcards[index].answer,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 20),
                        SizedBox(width: 12),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 20, color: Colors.red),
                        SizedBox(width: 12),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit(index);
                  } else if (value == 'delete') {
                    onDelete(index);
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color.fromARGB(255, 166, 165, 243)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: onAdd,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 32),
        ),
      ),
    );
  }
}
