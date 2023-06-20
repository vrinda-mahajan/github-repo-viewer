import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repo_viewer/auth/application/auth_notifier.dart';
import 'package:github_repo_viewer/auth/shared/providers.dart';
import 'package:github_repo_viewer/core/presentation/routes/app_routes.dart';
import 'package:github_repo_viewer/core/presentation/routes/app_routes.gr.dart';
import 'package:github_repo_viewer/core/shared/provider.dart';

final initializationProvider = FutureProvider<Unit>((ref) async {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  await ref.read(sembastProvider).init();
  // setting up the dio instance
  ref.read(dioProvider)
    ..options = BaseOptions(
      headers: {
        'Accept': 'application/vnd.github.html+json',
      },
      validateStatus: (status) => status! >= 200 && status < 300 || status == 304,
    )
    ..interceptors.add(ref.read(oAuth2InterceptorProvider));

  await authNotifier.checkAndUpdateAuthStatus();
  return unit;
});

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (previous, next) {});
    ref.listen<AuthState>(authNotifierProvider, (context, state) {
      state.maybeMap(
        orElse: () {},
        authenticated: (_) {
          _appRouter.pushAndPopUntil(
            const StarredReposRoute(),
            predicate: (route) => false,
          );
        },
        unauthenticated: (_) {
          _appRouter.pushAndPopUntil(
            const SignInRoute(),
            predicate: (route) => false,
          );
        },
      );
    });
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Repo Viewer',
    );
  }
}
