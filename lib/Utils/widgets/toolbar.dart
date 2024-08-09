import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopliax_todo/Providers/todo_provider.dart';

class Toolbar extends HookConsumerWidget {
  const Toolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${ref.watch(uncompletedTodosCount)} items left',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Tooltip(
              key: allFilterKey,
              message: 'All todos',
              child: TextButton(
                onPressed: () => ref.read(todoListFilter.notifier).state =
                    TodoListFilter.all,
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor:
                      WidgetStateProperty.all(textColorFor(TodoListFilter.all)),
                ),
                child: const Text('All'),
              ),
            ),
            Tooltip(
              key: activeFilterKey,
              message: 'Only uncompleted todos',
              child: TextButton(
                onPressed: () => ref.read(todoListFilter.notifier).state =
                    TodoListFilter.active,
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: WidgetStateProperty.all(
                    textColorFor(TodoListFilter.active),
                  ),
                ),
                child: const Text('Active'),
              ),
            ),
            Tooltip(
              key: completedFilterKey,
              message: 'Only completed todos',
              child: TextButton(
                onPressed: () => ref.read(todoListFilter.notifier).state =
                    TodoListFilter.completed,
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: WidgetStateProperty.all(
                    textColorFor(TodoListFilter.completed),
                  ),
                ),
                child: const Text('Completed'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
