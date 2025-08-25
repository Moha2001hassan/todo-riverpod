import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/features/task_management/presentation/screens/add_task_screen.dart';

import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/task_management/presentation/screens/main_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import 'app_routes.dart';
import 'go_router_refresh_stream.dart';

part 'routes.g.dart';

enum AppRouter { home, signIn, register , addTask}

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

@riverpod
GoRouter goRouter(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: AppRoutes.signIn,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;
      if (isLoggedIn &&
          (state.uri.toString() == AppRoutes.signIn ||
              state.uri.toString() == AppRoutes.register)) {
        return AppRoutes.main;
      } else if (!isLoggedIn &&
          state.uri.toString().startsWith(AppRoutes.main)) {
        return AppRoutes.signIn;
      } else {
        return null;
      }
    },
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    routes: [
      GoRoute(
        path: AppRoutes.main,
        name: AppRouter.home.name,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        name: AppRouter.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRouter.register.name,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.addTask,
        name: AppRouter.addTask.name,
        builder: (context, state) => const AddTaskScreen(),
      ),
    ],
  );
}

// flutter pub run build_runner build --delete-conflicting-outputs
