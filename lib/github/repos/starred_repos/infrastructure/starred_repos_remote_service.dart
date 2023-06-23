import 'package:dio/dio.dart';
import 'package:github_repo_viewer/core/infrastructure/dio_extensions.dart';
import 'package:github_repo_viewer/core/infrastructure/network_exception.dart';
import 'package:github_repo_viewer/core/infrastructure/remote_response.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_headers.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_headers_cache.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:github_repo_viewer/github/core/infrastructure/pagination_config.dart';

class StarredReposRemoteService {
  final Dio _dio;
  final GithubHeadersCache headersCache;

  StarredReposRemoteService(this._dio, this.headersCache);
  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
      int page) async {
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred',
      {
        'page': '$page',
        'per_page': PaginationConfig.itemsPerPage.toString(),
      },
    );
    final previousHeader = await headersCache.getHeaders(requestUri);

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            'If-none-match': previousHeader?.eTag ?? '',
          },
        ),
      );

      if (response.statusCode == 304) {
        return RemoteResponse.notModified(
            maxPage: previousHeader?.link?.maxPage ?? 0);
      } else if (response.statusCode == 200) {
        // saving to cache(inside store of sembast database)
        final headers = GithubHeaders.parse(response);
        await headersCache.saveHeaders(requestUri, headers);

        final convertedData = (response.data as List<dynamic>)
            .map((e) => GithubRepoDTO.fromJson(e as Map<String, dynamic>))
            .toList();
        return RemoteResponse.withNewData(convertedData,
            maxPage: headers.link?.maxPage ?? 1);
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
