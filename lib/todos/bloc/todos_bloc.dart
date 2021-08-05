import 'package:bloc_example/todos/todos.dart';
import 'package:equatable/equatable.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends ReplayBloc<TodosEvent, TodosState> {
  TodosBloc()
      : super(
          TodosState(
            status: TodosStatus.initial,
            todos: Todo.initialList,
          ),
        );

  @override
  Stream<TodosState> mapEventToState(covariant TodosEvent event) async* {
    if (event is TodoPriorityUpdated) {
      yield* _mapTodoPriorityUpdatedToState(event);
    } else if (event is TodoCompletedToggled) {
      yield* _mapTodoCompletedToggledToState(event);
    }
  }

  Stream<TodosState> _mapTodoPriorityUpdatedToState(
    TodoPriorityUpdated event,
  ) async* {
    final updatedTodos =
        state.todos.where((todo) => todo.id != event.todo.id).toList();

    updatedTodos.insert(event.position, event.todo);

    yield state.copyWith(todos: updatedTodos);
  }

  Stream<TodosState> _mapTodoCompletedToggledToState(
    TodoCompletedToggled event,
  ) async* {
    final todoIndex = state.todos.indexOf(event.todo);

    final updatedTodos =
        state.todos.where((todo) => todo.id != event.todo.id).toList();

    final updatedTodo = event.todo.copyWith(completed: !event.todo.completed);

    updatedTodos.insert(todoIndex, updatedTodo);

    yield state.copyWith(todos: updatedTodos);
  }
}
