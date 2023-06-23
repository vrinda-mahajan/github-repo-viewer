import 'package:dartz/dartz.dart';
import 'package:github_repo_viewer/core/domain/fresh.dart';
import 'package:github_repo_viewer/core/infrastructure/network_exception.dart';
import 'package:github_repo_viewer/github/core/domain/github_failure.dart';
import 'package:github_repo_viewer/github/core/domain/github_repo.dart';
import 'package:github_repo_viewer/github/repos/searched_repos/infrastructure/searched_repos_remote_service.dart';
import 'package:github_repo_viewer/github/repos/core/infrastructure/extensions.dart';

class SearchedReposRepository {
  final SearchedReposRemoteService _remoteService;

  SearchedReposRepository(
    this._remoteService,
  );

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getSearchedReposPage(
    int page,
    String query,
  ) async {
    try {
      final remotePageItems =
          await _remoteService.getSearchedReposPage(page, query);
      return right(
        await remotePageItems.maybeWhen(
          withNewData: (data, maxPage) => Fresh.yes(
            data.toDomain(),
            isNextPageAvailable: page < maxPage,
          ),
          orElse: () => Fresh.no(
            [],
            isNextPageAvailable: false,
          ),
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCode));
    }
  }
}
