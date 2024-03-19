class ToDoModel {
  final String title;
  final String description;
  final bool isCompleted;
  final String? createdAt;
  final String? id;

  ToDoModel(
      {required this.title,
      required this.description,
      required this.isCompleted,this.createdAt,this.id});

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
    id: json['_id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        isCompleted: json['is_completed'] ?? false, createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
  }
}
