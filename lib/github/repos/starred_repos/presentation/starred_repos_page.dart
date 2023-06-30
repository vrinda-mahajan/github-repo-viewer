import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repo_viewer/auth/shared/providers.dart';
import 'package:github_repo_viewer/github/core/shared/providers.dart';
import 'package:github_repo_viewer/github/repos/core/presentation/paginated_repos_list_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@RoutePage()
class StarredReposPage extends ConsumerStatefulWidget {
  const StarredReposPage({super.key});

  @override
  ConsumerState<StarredReposPage> createState() => _StarredReposPageState();
}

class _StarredReposPageState extends ConsumerState<StarredReposPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(starredReposNotifierProvider.notifier)
        .getNextStarredReposPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Starred Repos"),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).signOut();
                },
                icon: Icon(MdiIcons.logoutVariant))
          ],
        ),
        body: PaginatedReposListView(
          paginatedReposNotifierProvider: starredReposNotifierProvider,
          getNextPage: (ref) {
            ref
                .read(starredReposNotifierProvider.notifier)
                .getNextStarredReposPage();
          },
          noResultMessage: "That's about everything we could find in your starred repos right now.",
        ));
  }
}
