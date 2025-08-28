import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/firestore_repository.dart';
import '../../domain/task.dart';

part 'firestore_controller.g.dart';

@Riverpod(keepAlive: true)
class FirestoreController extends _$FirestoreController {
  @override
  FutureOr<void> build() {}

  Future<void> addTask({required Task task, required String userId}) async {
    state = const AsyncLoading();
    final firestoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(
      () => firestoreRepository.addTask(task: task, userId: userId),
    );
  }

  Future<void> updateTask({required Task task, required String userId}) async {
    state = const AsyncLoading();
    final firestoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(
      () => firestoreRepository.updateTask(task: task, userId: userId),
    );
  }

  Future<void> deleteTask({
    required String taskId,
    required String userId,
  }) async {
    state = const AsyncLoading();
    final firestoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(
      () => firestoreRepository.deleteTask(taskId: taskId, userId: userId),
    );
  }

  Future<void> updateTaskStatus({
    required String taskId,
    required String userId,
    required bool isCompleted,
  }) async {
    state = const AsyncLoading();
    final firestoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(
      () => firestoreRepository.updateTaskStatus(
        taskId: taskId,
        userId: userId,
        isCompleted: isCompleted,
      ),
    );
  }
}
