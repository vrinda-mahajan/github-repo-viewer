import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_repo_viewer/github/core/shared/providers.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/presentation/repo_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaginatedReposListView extends ConsumerWidget {
  const PaginatedReposListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(starredReposNotifierProvider);
    return ListView.builder(
      itemCount: state.map(
          initial: (_) => 0,
          loadInProgress: (_) => _.repos.entity.length + _.itemsPerPage,
          loadSuccess: (_) => _.repos.entity.length,
          loadFailure: (_) => _.repos.entity.length + 1),
      itemBuilder: (BuildContext context, int index) {
        return state.map(
            initial: (_) => Container(),
            loadInProgress: (_) => Container(),
            loadSuccess: (_) => RepoTile(repo: _.repos.entity[index]),
            loadFailure: (_) => Container());
      },
    );
  }
}
