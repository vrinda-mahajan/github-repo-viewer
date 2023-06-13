import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_repo_viewer/github/core/domain/user.dart';

part 'github_repo.freezed.dart';

@freezed
class GithubRepo with _$GithubRepo {
  const GithubRepo._();
  const factory GithubRepo({
    required User owner,
    required String name,
    required String fullName,
    required String description,
    required int stargazersCount,
  }) = _GithuRepo;

// related to business logic
  // String get fullName => '${owner.name}/$name'; (if fullname was not present in the response)
}
