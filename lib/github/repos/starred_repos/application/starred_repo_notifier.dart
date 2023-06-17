import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_repo_viewer/core/domain/fresh.dart';
import 'package:github_repo_viewer/github/core/domain/github_failure.dart';
import 'package:github_repo_viewer/github/core/domain/github_repo.dart';
import 'package:github_repo_viewer/github/core/infrastructure/pagination_config.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/infrastructure/starred_repos_repository.dart';

part 'starred_repo_notifier.freezed.dart';

@freezed
class StarredRepoState with _$StarredRepoState {
  const StarredRepoState._();
  const factory StarredRepoState.initial(
    Fresh<List<GithubRepo>> repos,
  ) = _Initial;
  const factory StarredRepoState.loadInProgress(
    Fresh<List<GithubRepo>> repos,
    int itemsPerPage,
  ) = _LoadInProgress;
  const factory StarredRepoState.loadSuccess(
    Fresh<List<GithubRepo>> repos, {
    required bool isNextPageAvailable,
  }) = _LoadSuccess;
  const factory StarredRepoState.loadFailure(
    Fresh<List<GithubRepo>> repos,
    GithubFailure failure,
  ) = _LoadFailure;
}

class StarredReposNotifier extends StateNotifier<StarredRepoState> {
  final StarredReposRepository _repository;

  StarredReposNotifier(this._repository)
      : super(
          StarredRepoState.initial(
            Fresh.yes([]),
          ),
        );
  int _page = 1;

  Future<void> getNextStarredReposPage() async {
    state = StarredRepoState.loadInProgress(
      state.repos,
      PaginationConfig.itemsPerPage,
    );
    final failureOrRepos = await _repository.getStarredReposPage(_page);
    state = failureOrRepos
        .fold((l) => StarredRepoState.loadFailure(state.repos, l), (r) {
      _page++;
      return StarredRepoState.loadSuccess(
        r.copyWith(
          entity: [
            ...state.repos.entity,
            ...r.entity,
          ],
        ),
        isNextPageAvailable: r.isNextPageAvailable ?? false,
      );
    });
  }
}
