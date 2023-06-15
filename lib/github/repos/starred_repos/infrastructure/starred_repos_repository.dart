import 'package:dartz/dartz.dart';
import 'package:github_repo_viewer/core/domain/fresh.dart';
import 'package:github_repo_viewer/core/infrastructure/network_exception.dart';
import 'package:github_repo_viewer/github/core/domain/github_failure.dart';
import 'package:github_repo_viewer/github/core/domain/github_repo.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:github_repo_viewer/github/repos/starred_repos/infrastructure/starred_repos_remote_service.dart';

class StarredReposRepository {
  final StarredReposRemoteService _remoteService;

  StarredReposRepository(this._remoteService);

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(
    int page,
  ) async {
    try {
      final remotePageItems = await _remoteService.getStarredReposPage(page);
      return right(remotePageItems.when(
        noConnection: (maxPage) => Fresh.no(
          // TODO-Local service
          [],
          isNextPageAvailable: page < maxPage,
        ),
        notModified: (maxPage) => Fresh.yes(
          // TODO-Local service
          [],
          isNextPageAvailable: page < maxPage,
        ),
        withNewData: (data, maxPage) => Fresh.yes(
          // TODO- save data in the Local service
          (data).toDomain(),
          isNextPageAvailable: page < maxPage,
        ),
      ));
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCode));
    }
  }
}

extension DTOListToDomain on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
