import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_repo_viewer/core/presentation/toast.dart';
import 'package:github_repo_viewer/github/core/presentation/no_result_display.dart';
import 'package:github_repo_viewer/github/repos/core/application/paginated_repos_notifier.dart';
import 'package:github_repo_viewer/github/repos/core/presentation/failure_repo_tile.dart';
import 'package:github_repo_viewer/github/repos/core/presentation/repo_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'loading_repo_tile.dart';

class PaginatedReposListView extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginatedReposNotifier, PaginatedRepoState>
      paginatedReposNotifierProvider;
  final void Function(WidgetRef ref) getNextPage;
  final String noResultMessage;

  const PaginatedReposListView({
    super.key,
    required this.getNextPage,
    required this.noResultMessage,
    required this.paginatedReposNotifierProvider,
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
    ref.listen<PaginatedRepoState>(widget.paginatedReposNotifierProvider,
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
    final state = ref.watch(widget.paginatedReposNotifierProvider);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final limit = metrics.maxScrollExtent - metrics.viewportDimension / 3;
        if (canLoadNextPage && metrics.pixels >= limit) {
          canLoadNextPage = false;
          widget.getNextPage(ref);
        }
        return false;
      },
      child: state.maybeWhen(
              loadSuccess: (repos, _) => repos.entity.isEmpty,
              orElse: () => false)
          ? NoResultDisplay(message: widget.noResultMessage)
          : _PaginatedListView(state: state),
    );
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    super.key,
    required this.state,
  });

  final PaginatedRepoState state;

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
