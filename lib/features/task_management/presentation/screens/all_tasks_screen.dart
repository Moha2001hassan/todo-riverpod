import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/core/common_widgets/async_value_ui.dart';
import '../../../../core/common_widgets/async_value_widget.dart';
import '../../../auth/data/auth_repository.dart';
import '../../data/firestore_repository.dart';
import '../../domain/task.dart';
import '../widgets/task_item.dart';

class AllTasksScreen extends ConsumerStatefulWidget {
  const AllTasksScreen({super.key});

  @override
  ConsumerState createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends ConsumerState<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final tasksAsyncValue = ref.watch(loadTasksProvider(userId));
    ref.listen<AsyncValue>(loadTasksProvider(userId), (_, state) {
      state.showAlertDialogOnError(context);
    });
    return Scaffold(
      appBar: AppBar(title: Text('All Tasks')),
      body: AsyncValueWidget<List<Task>>(
        value: tasksAsyncValue,
        data: (tasks) {
          return tasks.isEmpty
              ? const Center(child: Text('No tasks yet...'))
              : ListView.separated(
                  separatorBuilder: (_, _) =>
                      const Divider(height: 2, color: Colors.blue),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskItem(task: task);
                  },
                );
        },
      ),
    );
  }
}
