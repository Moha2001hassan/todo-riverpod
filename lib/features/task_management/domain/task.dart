class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String date;
  final String priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.date,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'date': date,
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
      date: map['date'] as String,
      priority: map['priority'] as String,
    );
  }
}
