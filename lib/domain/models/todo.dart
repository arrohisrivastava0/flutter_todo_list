//Data modal
class Todo{
  final int id;
  final String title;
  final bool isCompleted;

  Todo({required this.id, required this.title, this.isCompleted=false});

  Todo toggleCompletion(){
    return Todo(
        id: id,
        title: title,
        isCompleted: !isCompleted);
  }
  // Convert from database map to model
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
  // Convert a Todo object to a database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
