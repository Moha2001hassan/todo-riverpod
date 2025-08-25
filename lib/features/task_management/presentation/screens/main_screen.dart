import 'package:flutter/material.dart';
import '../../../auth/presentation/screens/account_screen.dart';
import 'add_task_screen.dart';
import 'all_tasks_screen.dart';
import 'completed_tasks_screen.dart';
import 'incomplete_tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.index = currentIndex;
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          AllTasksScreen(),
          CompletedTasksScreen(),
          IncompleteTasksScreen(),
          AddTaskScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        iconSize: 20,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'All'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Incomplete',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
