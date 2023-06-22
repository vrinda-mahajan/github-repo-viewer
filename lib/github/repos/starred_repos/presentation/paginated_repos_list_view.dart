import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_repo_viewer/core/presentation/toast.dart';
import 'package:github_repo_viewer/github/core/presentation/no_result_display.dart';
import 'package:github_repo_viewer/github/core/shared/providers.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/application/starred_repo_notifier.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/presentation/failure_repo_tile.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/presentation/repo_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'loading_repo_tile.dart';

class PaginatedReposListView extends ConsumerStatefulWidget {
  const PaginatedReposListView({
    super.key,
  });

  @override
  ConsumerState<PaginatedReposListView> createState() =>
      _PaginatedReposListViewState();
}

class _PaginatedReposListViewState
    extends ConsumerState<PaginatedReposListView> {
  bool canLoadNextPage = false;
  bool isNoConnectionToastShown = false;
  @override
  Widget build(BuildContext context) {
    ref.listen<StarredRepoState>(starredReposNotifierProvider,
        (previous, state) {
      state.map(
        initial: (_) => canLoadNextPage = true,
        loadInProgress: (_) => canLoadNextPage = false,
        loadSuccess: (_) {
          if (!_.repos.isFresh && !isNoConnectionToastShown) {
            isNoConnectionToastShown = true;
            ShowNoConnectionToast(
              "You're not online. Some information may be outdated.",
              context,
            );
          }
          canLoadNextPage = _.isNextPageAvailable;
        },
        loadFailure: (_) => canLoadNextPage = false,
      );
    });
    final state = ref.watch(starredReposNotifierProvider);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final limit = metrics.maxScrollExtent - metrics.viewportDimension / 3;
        if (canLoadNextPage && metrics.pixels >= limit) {
          canLoadNextPage = false;
          ref
              .read(starredReposNotifierProvider.notifier)
              .getNextStarredReposPage();
        }
        return false;
      },
      child: state.maybeWhen(
              loadSuccess: (repos, _) => repos.entity.isEmpty,
              orElse: () => false)
          ? const NoResultDisplay(
              message:
                  "That's about everything we could find in your starred repos right now.")
          : _PaginatedListView(state: state),
    );
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    super.key,
    required this.state,
  });

  final StarredRepoState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.map(
          initial: (_) => 0,
          loadInProgress: (_) => _.repos.entity.length + _.itemsPerPage,
          loadSuccess: (_) => _.repos.entity.length,
          loadFailure: (_) => _.repos.entity.length + 1),
      itemBuilder: (BuildContext context, int index) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) {
            if (index < _.repos.entity.length) {
              return RepoTile(
                repo: _.repos.entity[index],
              );
            } else {
              return const LoadingRepoTile();
            }
          },
          loadSuccess: (_) => RepoTile(repo: _.repos.entity[index]),
          loadFailure: (_) {
            if (index < _.repos.entity.length) {
              return RepoTile(
                repo: _.repos.entity[index],
              );
            } else {
              return FailureRepoTile(failure: _.failure);
            }
          },
        );
      },
    );
  }
}
