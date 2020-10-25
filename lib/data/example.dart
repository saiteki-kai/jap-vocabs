class Example {
  final String id;
  final String text;
  final String translation;

  const Example({this.id, this.text, this.translation});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'translation': translation,
    };
  }

  factory Example.fromMap(Map<String, dynamic> map) {
    return Example(
      id: map['id'],
      text: map['text'],
      translation: map['translation'],
    );
  }
}
