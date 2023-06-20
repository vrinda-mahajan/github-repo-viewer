import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_repo_viewer/github/core/domain/github_repo.dart';

class RepoTile extends StatelessWidget {
  final GithubRepo repo;
  const RepoTile({
    super.key,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(repo.fullName),
    );
  }
}
