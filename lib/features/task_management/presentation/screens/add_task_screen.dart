import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/core/common_widgets/async_value_ui.dart';
import 'package:todo_riverpod/features/auth/data/auth_repository.dart';
import 'package:todo_riverpod/features/task_management/presentation/widgets/title_description.dart';

import '../../../../utils/size_config.dart';
import '../../../../utils/styles.dart';
import '../../domain/task.dart';
import '../controller/firestore_controller.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<String> priorities = ['High', 'Medium', 'Low'];
  int selectedPriority = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final userId = ref.watch(currentUserProvider)!.uid;
    final state = ref.watch(firestoreControllerProvider);

    ref.listen(firestoreControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Task',
          style: AppStyles.titleTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            TitleDescription(
              title: 'Task Title',
              controller: _titleController,
              maxLines: 1,
              prefixIcon: Icons.notes,
              hintText: 'Enter Task Title',
            ),
            SizedBox(height: SizeConfig.getProportionateHeight(10)),
            TitleDescription(
              title: 'Task Description',
              controller: _descriptionController,
              prefixIcon: Icons.notes,
              hintText: 'Enter Task Description',
            ),
            SizedBox(height: SizeConfig.getProportionateHeight(20)),
            Row(
              children: [
                Text(
                  'Priority',
                  style: AppStyles.headingTextStyle.copyWith(fontSize: 18),
                ),
                Expanded(
                  child: SizedBox(
                    height: SizeConfig.getProportionateHeight(40),
                    child: ListView.builder(
                      itemCount: priorities.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final priority = priorities[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPriority = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.getProportionateWidth(10),
                            ),
                            padding: EdgeInsets.all(
                              SizeConfig.getProportionateWidth(10),
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedPriority == index
                                  ? Colors.green
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              priority,
                              style: AppStyles.normalTextStyle.copyWith(
                                fontSize: 15,
                                color: selectedPriority == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.getProportionateHeight(20)),
            Material(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () {
                  final title = _titleController.text.trim();
                  final description = _descriptionController.text.trim();
                  final priority = priorities[selectedPriority];

                  if (title.isNotEmpty && description.isNotEmpty) {
                    final task = Task(
                      title: title,
                      description: description,
                      priority: priority,
                      date: DateTime.now().toIso8601String(),
                    );
                    ref
                        .read(firestoreControllerProvider.notifier)
                        .addTask(task: task, userId: userId);
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  alignment: Alignment.center,
                  height: SizeConfig.getProportionateHeight(50),
                  width: SizeConfig.screenWidth,
                  child: state.isLoading
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 30),
                            Text(
                              'Add Task',
                              style: AppStyles.normalTextStyle.copyWith(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
