import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopliax_todo/Config/config.dart';
import 'package:shopliax_todo/Providers/todo_provider.dart';
import 'package:shopliax_todo/Data%20Source/Todo/todo.dart';
import 'package:shopliax_todo/Utils/app_colors.dart';
import 'package:shopliax_todo/Utils/widgets/toolbar.dart';

final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

//
class Home extends HookConsumerWidget {
  static Home builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const Home();
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final _selectedIndex = useState(0);

    // Define the bottom navigation bar items
    final bottomNavBar = BottomNavigationBar(
      currentIndex: _selectedIndex.value,
      backgroundColor: white,
      selectedItemColor: blue,
      onTap: (index) {
        _selectedIndex.value = index;
        switch (index) {
          case 0:
            context.go(RouteLocation.home);
            break;
          case 1:
            context.go(RouteLocation.photoScreen);
            break;
          case 2:
            context.go(RouteLocation.createTodo);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'API Data',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Todo',
        ),
      ],
    );

    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Todo List"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            const Toolbar(),
            if (todos.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < todos.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              // drag to the side to remove todo
              Dismissible(
                key: ValueKey(todos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(todos[i]);
                },
                child: ProviderScope(
                  overrides: [
                    _currentTodo.overrideWithValue(todos[i]),
                  ],
                  child: const TodoItem(),
                ),
              ),
            ],
          ],
        ),
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}

class TodoItem extends HookConsumerWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            // Commit changes only when the textfield is unfocused, for performance
            ref
                .read(todoListProvider.notifier)
                .edit(id: todo.id, description: textEditingController.text);
          }
        },
        child: Card(
          color: Colors.white,
          child: ListTile(
            onTap: () {},
            leading: Checkbox(
              value: todo.completed,
              onChanged: (value) =>
                  ref.read(todoListProvider.notifier).toggle(todo.id),
            ),
            title: itemIsFocused
                ? TextField(
                    autofocus: true,
                    focusNode: textFieldFocusNode,
                    controller: textEditingController,
                  )
                : Text(todo.description),
            subtitle: const Text(
              "slide to remove todo",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: GestureDetector(
              onTap: () {
                itemFocusNode.requestFocus();
                textFieldFocusNode.requestFocus();
              },
              child: const Icon(
                Icons.edit,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(
    () {
      void listener() {
        isFocused.value = node.hasFocus;
      }

      node.addListener(listener);
      return () => node.removeListener(listener);
    },
    [node],
  );

  return isFocused.value;
}
