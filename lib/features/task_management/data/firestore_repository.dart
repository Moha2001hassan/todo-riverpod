import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/task.dart';

part 'firestore_repository.g.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepository(this._firestore);

  Future<void> addTask({required Task task, required String userId}) async {
    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .add(task.toMap());

    await docRef.update({'id': docRef.id});
  }

  Future<void> updateTask({required Task task, required String userId}) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(task.id)
        .update(task.toMap());
  }

  Stream<List<Task>> loadTasks(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList(),
        );
  }

  Stream<List<Task>> loadCompletedTasks(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList(),
        );
  }

  Stream<List<Task>> loadInCompletedTasks(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList(),
        );
  }

  Future<void> deleteTask({
    required String taskId,
    required String userId,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  Future<void> updateTaskStatus({
    required String taskId,
    required String userId,
    required bool isCompleted,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .update({'isCompleted': isCompleted});
  }
}

// _________________________ RIVERPOD _________________________
@Riverpod(keepAlive: true)
FirestoreRepository firestoreRepository(Ref ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Task>> loadTasks(Ref ref, String userId) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadTasks(userId);
}

@riverpod
Stream<List<Task>> loadCompletedTasks(Ref ref, String userId) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadCompletedTasks(userId);
}

@riverpod
Stream<List<Task>> loadInCompletedTasks(Ref ref, String userId) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadInCompletedTasks(userId);
}
// _________________________ RIVERPOD _________________________

// dart run build_runner build --delete-conflicting-outputs