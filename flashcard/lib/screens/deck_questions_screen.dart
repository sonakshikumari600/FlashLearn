import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../services/profile_service.dart';
import 'deck_flashcard_screen.dart';
import 'profile_screen.dart';

class DeckQuestionsScreen extends StatefulWidget {
  final ProfileService profileService;
  final Deck deck;

  const DeckQuestionsScreen({
    super.key,
    required this.profileService,
    required this.deck,
  });

  @override
  State<DeckQuestionsScreen> createState() => _DeckQuestionsScreenState();
}

class _DeckQuestionsScreenState extends State<DeckQuestionsScreen> {
  final ProfileService _profileService = ProfileService.instance;
  void _addQuestion() {
    final questionController = TextEditingController();
    final answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Add Question to ${widget.deck.name}'),
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
                  widget.deck.questions.add(questionController.text);
                  widget.deck.answers.add(answerController.text);
                  widget.deck.cardCount = widget.deck.questions.length;
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editQuestion(int index) {
    final questionController = TextEditingController(text: widget.deck.questions[index]);
    final answerController = TextEditingController(text: widget.deck.answers[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Edit Question'),
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
                  widget.deck.questions[index] = questionController.text;
                  widget.deck.answers[index] = answerController.text;
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

  void _deleteQuestion(int index) {
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
                'Delete Question?',
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
                          widget.deck.questions.removeAt(index);
                          widget.deck.answers.removeAt(index);
                          widget.deck.cardCount = widget.deck.questions.length;
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
        title: Row(
          children: [
            Text(
              widget.deck.emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.deck.name,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.deck.cardCount} Questions',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
      body: widget.deck.questions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.quiz_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text(
                    'No questions yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Long press a deck to add questions',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.deck.questions.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
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
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFA78BFA), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              title: Text(
                widget.deck.questions[index],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              trailing: PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Color(0xFFA78BFA)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view',
                    child: Row(
                      children: [
                        Icon(Icons.visibility_outlined, size: 20, color: Color(0xFF8B5CF6)),
                        SizedBox(width: 12),
                        Text('View', style: TextStyle(color: Color(0xFF8B5CF6))),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 20, color: Color(0xFF4A90E2)),
                        SizedBox(width: 12),
                        Text('Edit', style: TextStyle(color: Color(0xFF4A90E2))),
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
                  if (value == 'view') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeckFlashcardScreen(
                          deck: widget.deck,
                          startIndex: index,
                        ),
                      ),
                    );
                  } else if (value == 'edit') {
                    _editQuestion(index);
                  } else if (value == 'delete') {
                    _deleteQuestion(index);
                  }
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeckFlashcardScreen(
                      deck: widget.deck,
                      startIndex: index,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
