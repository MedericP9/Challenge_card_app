class CardModel {
  final int id;
  final String title;
  final String text;
  final String pack;
  bool judged;

  CardModel({
    required this.id,
    required this.title,
    required this.text,
    required this.pack,
    this.judged = false,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      pack: json['pack'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'pack': pack,
    };
  }
}