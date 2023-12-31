import 'package:github_repo_viewer/core/infrastructure/sembast_database.dart';
import 'package:github_repo_viewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:github_repo_viewer/github/core/infrastructure/pagination_config.dart';
import 'package:sembast/sembast.dart';
import 'package:collection/collection.dart';

class StarredReposLocalService {
  final SembastDatabase _sembastDatabase;
  final _store = intMapStoreFactory.store('starredRepos');

  StarredReposLocalService(this._sembastDatabase);

  // insert + update starred repo pages
  Future<void> upsert(List<GithubRepoDTO> dtos, int page) async {
    final sembastPage = page - 1;
    await _store
        .records(dtos.mapIndexed(
            (index, _) => index + PaginationConfig.itemsPerPage * sembastPage))
        .put(
          _sembastDatabase.instance,
          dtos.map((e) => e.toJson()).toList(),
        );
    // print("from upsert");
    // print(await _store.count(_sembastDatabase.instance));
  }

  Future<List<GithubRepoDTO>> getPage(int page) async {
    final sembastPage = page - 1;

    final records = await _store.find(
      _sembastDatabase.instance,
      finder: Finder(
        limit: PaginationConfig.itemsPerPage,
        offset: sembastPage * PaginationConfig.itemsPerPage,
      ),
    );

    return records.map((e) => GithubRepoDTO.fromJson(e.value)).toList();
  }

  Future<int> getLocalPageCount() async {
    final repoCount = await _store.count(_sembastDatabase.instance);
    // print(repoCount);
    return (repoCount / PaginationConfig.itemsPerPage).ceil();
  }
}
