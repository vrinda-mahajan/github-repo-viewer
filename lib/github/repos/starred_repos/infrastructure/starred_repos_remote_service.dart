import 'package:dio/dio.dart';
import 'package:github_repo_viewer/core/infrastructure/remote_response.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_headers_cache.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio;
  final GithubHeadersCache headersCache;

  StarredReposRemoteService(this._dio, this.headersCache);
  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
      int page) async {}
}
