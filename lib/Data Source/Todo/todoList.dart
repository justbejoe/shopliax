import 'package:riverpod/riverpod.dart';
import 'package:shopliax_todo/Data%20Source/Todo/todo.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// An object that controls a list of [Todo].
class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [
        /// Creates a [TodoList] and initialise it with pre-defined values.
        const Todo(id: 'todo-0', description: 'Groceries shopping'),
        const Todo(id: 'todo-1', description: 'Hit the Gym'),
      ];

  // add todo
  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  // toggle the state of completion
  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  // edit the seleted todo
  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  // remove the selected todo from the list
  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
