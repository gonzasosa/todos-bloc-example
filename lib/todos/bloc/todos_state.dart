part of 'todos_bloc.dart';

enum TodosStatus { initial, loading, completed, failure }

class TodosState extends Equatable {
  const TodosState({required this.status, required this.todos});

  final TodosStatus status;
  final List<Todo> todos;

  @override
  List<Object> get props => [status, todos];

  TodosState copyWith({TodosStatus? status, List<Todo>? todos}) {
    return TodosState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
    );
  }
}
