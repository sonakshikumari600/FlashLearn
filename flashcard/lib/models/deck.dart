class Deck {
  String name;
  String emoji;
  int cardCount;
  String color;
  List<String> questions;
  List<String> answers;

  Deck({
    required this.name,
    required this.emoji,
    required this.cardCount,
    required this.color,
    required this.questions,
    required this.answers,
  });
}
