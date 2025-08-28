import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_riverpod/features/auth/data/auth_repository.dart';
import 'package:todo_riverpod/features/task_management/data/firestore_repository.dart';

import '../../../../utils/size_config.dart';
import '../../../../utils/styles.dart';
import '../../domain/task.dart';

class TaskItem extends ConsumerStatefulWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  ConsumerState<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.title,
                  style: AppStyles.headingTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(10)),
                Text(
                  widget.task.description,
                  style: AppStyles.normalTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(20)),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      height: SizeConfig.getProportionateHeight(40),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.task.priority.toUpperCase(),
                        style: AppStyles.normalTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.getProportionateWidth(20)),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      height: SizeConfig.getProportionateHeight(40),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            formatDateTime(widget.task.date),
                            style: AppStyles.normalTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Transform.scale(
                  scale: 1.8,
                  child: Checkbox(
                    value: widget.task.isCompleted,
                    activeColor: Colors.blue,
                    onChanged: (bool? value) {
                      if (value == null) {
                        return;
                      } else {
                        final userId = ref.read(currentUserProvider)!.uid;
                        ref
                            .read(firestoreRepositoryProvider)
                            .updateTaskStatus(
                              taskId: widget.task.id,
                              userId: userId,
                              isCompleted: value,
                            );
                      }
                    },
                  ),
                ),

                SizedBox(height: SizeConfig.getProportionateHeight(10)),

                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(10)),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.white,
                    onPressed: () {
                      _deleteTask(widget.task.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _deleteTask(String taskId) {
    final userId = ref.read(currentUserProvider)!.uid;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure', style: AppStyles.titleTextStyle),
          icon: const Icon(Icons.warning_rounded, size: 60, color: Colors.red),
          alignment: Alignment.center,
          content: Text('Click Delete button to delete this task'),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () => context.pop(),
              child: Text(
                'Cancel',
                style: AppStyles.normalTextStyle.copyWith(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await ref
                    .read(firestoreRepositoryProvider)
                    .deleteTask(taskId: taskId, userId: userId);

                if(context.mounted) context.pop();
              },
              child: Text(
                'Delete',
                style: AppStyles.normalTextStyle.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

String formatDateTime(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  return formattedDate;
}
