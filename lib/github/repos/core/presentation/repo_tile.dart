import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_repo_viewer/github/core/domain/github_repo.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RepoTile extends StatelessWidget {
  final GithubRepo repo;
  const RepoTile({
    super.key,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(repo.name),
      subtitle: Text(
        repo.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(repo.owner.avatarUrlSmall),
        backgroundColor: Colors.transparent,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MdiIcons.starOutline),
          Text(
            repo.stargazersCount.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
