import 'package:bloc_example/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodosBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todos App'),
          actions: const [_UndoButton(), _RedoButton()],
        ),
        body: const _TodosList(),
      ),
    );
  }
}

class _UndoButton extends StatelessWidget {
  const _UndoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (context.read<TodosBloc>().canUndo) {
          context.read<TodosBloc>().undo();
        }
      },
      icon: const Icon(Icons.undo),
      tooltip: 'Undo',
    );
  }
}

class _RedoButton extends StatelessWidget {
  const _RedoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (context.read<TodosBloc>().canRedo) {
          context.read<TodosBloc>().redo();
        }
      },
      icon: const Icon(Icons.redo),
      tooltip: 'Redo',
    );
  }
}

class _TodosList extends StatelessWidget {
  const _TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.select((TodosBloc bloc) => bloc.state.todos);

    return Container(
      padding: const EdgeInsets.all(14.0),
      child: ReorderableListView.builder(
        itemCount: todos.length,
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) newIndex -= 1;

          context.read<TodosBloc>().add(
                TodoPriorityUpdated(
                  position: newIndex,
                  todo: todos[oldIndex],
                ),
              );
        },
        itemBuilder: (_, index) {
          return _TodoListTile(
            key: ValueKey('todosPage_todosList_todosListTile_$index'),
            position: index,
            todo: todos[index],
          );
        },
      ),
    );
  }
}

class _TodoListTile extends StatelessWidget {
  const _TodoListTile({
    Key? key,
    required this.position,
    required this.todo,
  }) : super(key: key);

  final int position;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: todo.completed,
      onChanged: (value) {
        context
            .read<TodosBloc>()
            .add(TodoCompletedToggled(completed: value ?? false, todo: todo));
      },
      secondary: Container(
        alignment: Alignment.center,
        height: 40.0,
        width: 20.0,
        child: Text(
          position.toString() + '.',
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
      title: Text(todo.task),
      subtitle: Text(todo.description),
    );
  }
}
