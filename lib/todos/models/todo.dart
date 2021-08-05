import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo({
    required this.id,
    required this.completed,
    required this.task,
    required this.description,
  });

  static get initialList => [
        const Todo(
          id: 0,
          completed: false,
          task: 'Clean the House',
          description: 'Clean the bedroom and the kitchen',
        ),
        const Todo(
          id: 1,
          completed: false,
          task: 'Wash the Dishes',
          description: 'Wash just the first 4 dishes',
        ),
        const Todo(
          id: 2,
          completed: false,
          task: 'Go to the Gym',
          description: 'Today is running day',
        ),
        const Todo(
          id: 3,
          completed: false,
          task: 'Go to the Cinema',
          description: 'Free day',
        ),
      ];

  final int id;
  final bool completed;
  final String task;
  final String description;

  @override
  List<Object> get props => [id, completed, task, description];

  Todo copyWith({bool? completed}) {
    return Todo(
      id: id,
      completed: completed ?? this.completed,
      task: task,
      description: description,
    );
  }
}
