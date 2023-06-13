import 'package:dio/dio.dart';
import 'package:github_repo_viewer/core/infrastructure/remote_response.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio;

  StarredReposRemoteService(this._dio);
  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
      int page) async {}
}
