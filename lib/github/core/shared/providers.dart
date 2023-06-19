import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repo_viewer/core/shared/provider.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_headers_cache.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/application/starred_repo_notifier.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/infrastructure/starred_repos_local_service.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/infrastructure/starred_repos_remote_service.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/infrastructure/starred_repos_repository.dart';

final githubHeadersCacheProvider = Provider(
  (ref) => GithubHeadersCache(ref.watch(sembastProvider)),
);

final starredReposRemoteServiceProvider = Provider(
  (ref) => StarredReposRemoteService(
      ref.watch(dioProvider), ref.watch(githubHeadersCacheProvider)),
);

final starredReposLocalServiceProvider = Provider(
  (ref) => StarredReposLocalService(ref.watch(sembastProvider)),
);

final starredReposRepositoryProvider = Provider(
  (ref) => StarredReposRepository(
    ref.watch(starredReposRemoteServiceProvider),
    ref.watch(starredReposLocalServiceProvider),
  ),
);

final starredReposNotifierProvider =
    StateNotifierProvider<StarredReposNotifier, StarredRepoState>(
  (ref) => StarredReposNotifier(ref.watch(starredReposRepositoryProvider)),
);
