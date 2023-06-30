import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repo_viewer/auth/shared/providers.dart';
import 'package:github_repo_viewer/github/core/shared/providers.dart';
import 'package:github_repo_viewer/github/repos/core/presentation/paginated_repos_list_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@RoutePage()
class SearchedReposPage extends ConsumerStatefulWidget {
  final String searchTerm;
  const SearchedReposPage({
    super.key,
    required this.searchTerm,
  });

  @override
  ConsumerState<SearchedReposPage> createState() => _SearchedReposPageState();
}

class _SearchedReposPageState extends ConsumerState<SearchedReposPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(searchedReposNotifierProvider.notifier)
        .getNextSearchedReposPage(widget.searchTerm));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Searched Repos"),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).signOut();
                },
                icon: Icon(MdiIcons.logoutVariant))
          ],
        ),
        body: PaginatedReposListView(
          paginatedReposNotifierProvider: searchedReposNotifierProvider,
          getNextPage: (ref) {
            ref
                .read(searchedReposNotifierProvider.notifier)
                .getNextSearchedReposPage(widget.searchTerm);
          },
          noResultMessage:
              "This is all we could find for your search term. Really...",
        ));
  }
}
