import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../services/profile_service.dart';
import 'deck_questions_screen.dart';
import 'deck_flashcard_screen.dart';
import 'profile_screen.dart';

class DeckManagementScreen extends StatefulWidget {
  final ProfileService profileService;

  const DeckManagementScreen({
    super.key,
    required this.profileService,
  });

  @override
  State<DeckManagementScreen> createState() => _DeckManagementScreenState();
}

class _DeckManagementScreenState extends State<DeckManagementScreen> {
  final ProfileService _profileService = ProfileService.instance;
  List<Deck> decks = [
    Deck(
      name: 'Flutter',
      emoji: '📱',
      cardCount: 15,
      color: 'BBDEFB',
      questions: [
        'What is Flutter?',
        'What language does Flutter use?',
        'What is a Widget?',
        'What is StatelessWidget?',
        'What is StatefulWidget?',
        'What is setState()?',
        'What is hot reload?',
        'What is Scaffold?',
        'What is Navigator?',
        'What is pubspec.yaml?',
        'What is Container widget?',
        'What is Column widget?',
        'What is Row widget?',
        'What is MaterialApp?',
        'What is BuildContext?',
      ],
      answers: [
        'Flutter is an open-source UI toolkit by Google for building apps.',
        'Dart',
        'A widget is a building block of Flutter UI.',
        'A widget that does not change its state.',
        'A widget that can change its state dynamically.',
        'It updates the UI when state changes.',
        'It updates code instantly without restarting the app.',
        'A basic structure for UI with AppBar, body, etc.',
        'It is used for screen navigation.',
        'File that manages dependencies and assets.',
        'A box used for styling and layout.',
        'It arranges widgets vertically.',
        'It arranges widgets horizontally.',
        'Root widget of Flutter app.',
        'It tells location of widget in widget tree.',
      ],
    ),
    Deck(
      name: 'Python',
      emoji: '🐍',
      cardCount: 15,
      color: 'C8E6C9',
      questions: [
        'What is Python?',
        'Is Python compiled or interpreted?',
        'What is a variable?',
        'What is a list?',
        'What is tuple?',
        'What is dictionary?',
        'What is function?',
        'What is indentation?',
        'What is loop?',
        'What is if-else?',
        'What is OOP?',
        'What is class?',
        'What is object?',
        'What is exception handling?',
        'What is file handling?',
      ],
      answers: [
        'Python is a high-level programming language.',
        'Interpreted language.',
        'A container to store data.',
        'Ordered collection of items.',
        'Immutable collection of items.',
        'Key-value pair data structure.',
        'Block of reusable code.',
        'Space that defines code blocks.',
        'Used to repeat code.',
        'Conditional statement.',
        'Object-Oriented Programming.',
        'Blueprint of object.',
        'Instance of class.',
        'Handling runtime errors.',
        'Reading and writing files.',
      ],
    ),
    Deck(
      name: 'General Knowledge',
      emoji: '📘',
      cardCount: 15,
      color: 'FFF9C4',
      questions: [
        'Capital of India?',
        'National animal of India?',
        'National bird of India?',
        'Largest planet?',
        'Smallest continent?',
        'Fastest land animal?',
        'Currency of India?',
        'Who is Prime Minister of India?',
        'Longest river in India?',
        'Largest ocean?',
        'National flower of India?',
        'Largest country by area?',
        'Most populated country?',
        'Capital of Japan?',
        'Father of Nation (India)?',
      ],
      answers: [
        'New Delhi',
        'Tiger',
        'Peacock',
        'Jupiter',
        'Australia',
        'Cheetah',
        'Indian Rupee',
        'Narendra Modi',
        'Ganga',
        'Pacific Ocean',
        'Lotus',
        'Russia',
        'India',
        'Tokyo',
        'Mahatma Gandhi',
      ],
    ),
    Deck(
      name: 'DSA',
      emoji: '💻',
      cardCount: 15,
      color: 'E1BEE7',
      questions: [
        'What is array?',
        'What is linked list?',
        'Stack follows which order?',
        'Queue follows which order?',
        'What is recursion?',
        'What is binary search?',
        'Time complexity meaning?',
        'Space complexity meaning?',
        'What is sorting?',
        'Bubble sort works on?',
        'What is tree?',
        'What is graph?',
        'What is DFS?',
        'What is BFS?',
        'What is hash map?',
      ],
      answers: [
        'Collection of elements stored in contiguous memory.',
        'Nodes connected using pointers.',
        'LIFO (Last In First Out)',
        'FIFO (First In First Out)',
        'Function calling itself.',
        'Searching by dividing sorted array.',
        'Time taken by algorithm.',
        'Memory used by algorithm.',
        'Arranging data in order.',
        'Repeated swapping.',
        'Hierarchical data structure.',
        'Nodes connected by edges.',
        'Depth First Search.',
        'Breadth First Search.',
        'Key-value storage structure.',
      ],
    ),
  ];

  void _addNewDeck() {
    final nameController = TextEditingController();
    final emojiController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Create New Deck'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Deck Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emojiController,
              decoration: InputDecoration(
                labelText: 'Emoji',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && emojiController.text.isNotEmpty) {
                setState(() {
                  decks.add(Deck(
                    name: nameController.text,
                    emoji: emojiController.text,
                    cardCount: 0,
                    color: 'E1BEE7',
                    questions: [],
                    answers: [],
                  ));
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _editDeck(int index) {
    final nameController = TextEditingController(text: decks[index].name);
    final emojiController = TextEditingController(text: decks[index].emoji);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Edit Deck'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Deck Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emojiController,
              decoration: InputDecoration(
                labelText: 'Emoji',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && emojiController.text.isNotEmpty) {
                setState(() {
                  decks[index].name = nameController.text;
                  decks[index].emoji = emojiController.text;
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteDeck(int index) {
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
                'Delete Deck?',
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
                          decks.removeAt(index);
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

  void _addQuestionToDeck(int deckIndex) {
    final questionController = TextEditingController();
    final answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Add Question to ${decks[deckIndex].name}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: answerController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (questionController.text.isNotEmpty && answerController.text.isNotEmpty) {
                setState(() {
                  decks[deckIndex].questions.add(questionController.text);
                  decks[deckIndex].answers.add(answerController.text);
                  decks[deckIndex].cardCount = decks[deckIndex].questions.length;
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

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
          'My Study Decks',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        toolbarHeight: 80,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFF8B5CF6)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    profileService: _profileService,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: decks.length,
          itemBuilder: (context, index) {
            return buildDeckCard(decks[index], index);
          },
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF2196F3)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A90E2).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _addNewDeck,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 32),
        ),
      ),
    );
  }

  Widget buildDeckCard(Deck deck, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeckQuestionsScreen(
              deck: deck,
              profileService: _profileService,
            ),
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.visibility_outlined, color: Color(0xFF8B5CF6)),
                  title: const Text('View'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeckFlashcardScreen(
                          deck: deck,
                          startIndex: 0,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit_outlined, color: Color(0xFF4A90E2)),
                  title: const Text('Edit'),
                  onTap: () {
                    Navigator.pop(context);
                    _editDeck(index);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text('Delete'),
                  onTap: () {
                    Navigator.pop(context);
                    _deleteDeck(index);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_circle_outline, color: Color(0xFF10B981)),
                  title: const Text('Add Questions'),
                  onTap: () {
                    Navigator.pop(context);
                    _addQuestionToDeck(index);
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(int.parse('0xFF${deck.color}')),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    deck.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${deck.cardCount}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                deck.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${deck.cardCount} Questions',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
