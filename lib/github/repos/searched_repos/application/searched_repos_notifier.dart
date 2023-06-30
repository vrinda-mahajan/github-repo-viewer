import 'package:github_repo_viewer/github/repos/core/application/paginated_repos_notifier.dart';
import 'package:github_repo_viewer/github/repos/searched_repos/infrastructure/searched_repos_repository.dart';

class SearchedReposNotifier extends PaginatedReposNotifier {
  final SearchedReposRepository _repository;

  SearchedReposNotifier(this._repository) : super();

  Future<void> getNextSearchedReposPage(String query) async {
    super.getNextPage((page) => _repository.getSearchedReposPage(page, query));
  }
}
