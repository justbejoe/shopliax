import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopliax_todo/Config/routes/route_location.dart';
import 'package:shopliax_todo/Providers/todo_provider.dart';
import 'package:shopliax_todo/Utils/app_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreateTodoScreen extends HookConsumerWidget {
  static CreateTodoScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateTodoScreen();

  const CreateTodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _height = MediaQuery.sizeOf(context).height;
    final _weight = MediaQuery.sizeOf(context).width;
    final newTodoController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Todo"),
        leading: IconButton(
          onPressed: () {
            context.go(RouteLocation.home);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const Spacer(),
            Center(
              child: Icon(
                Icons.calendar_month,
                size: 200,
                color: Colors.grey.shade200,
              ),
            ),
            SizedBox(height: _height * 0.05),
            const Text(
              "Todo Title",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Textfield for todo title/description
            TextField(
              key: addTodoKey,
              controller: newTodoController,
              decoration: const InputDecoration(
                labelText: 'Enter your to do',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  ref.read(todoListProvider.notifier).add(value);
                  newTodoController.clear();
                  context.go(RouteLocation.home);
                } else {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "title cannot be empty",
                    ),
                  );
                }
              },
            ),
            const Spacer(),
            Center(
              child: Container(
                width: _weight / 1.5,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  child: const Text(
                    "Create Todo",
                    style: TextStyle(
                      color: white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    if (newTodoController.text.isNotEmpty) {
                      ref
                          .read(todoListProvider.notifier)
                          .add(newTodoController.text);
                      newTodoController.clear();
                      context.go(RouteLocation.home);
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message: "title cannot be empty",
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
