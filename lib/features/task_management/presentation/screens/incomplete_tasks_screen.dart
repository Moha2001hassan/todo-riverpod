import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncompleteTasksScreen extends ConsumerWidget {
  const IncompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: const Center(child: Text('Incomplete Tasks Screen')),
    );
  }
}
