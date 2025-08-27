import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/firestore_repository.dart';
import '../../domain/task.dart';

class FirestoreController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    throw UnimplementedError();
  }

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
