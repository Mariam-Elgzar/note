
class Tasks {
  int? id;
  String title;
  String body;
  DateTime? date;

  Tasks({
    this.id,
    required this.title,
    required this.body,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'date': date,
    };
  }

  factory Tasks.fromMap(Map<String, dynamic> map) {
    return Tasks(
      title: map['title'],
      body: map['body'],
      date: map['date'],
      id: map['id'],
    );
  }
}
