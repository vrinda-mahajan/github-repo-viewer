// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GithubRepo {
  User get owner => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get stargazersCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GithubRepoCopyWith<GithubRepo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubRepoCopyWith<$Res> {
  factory $GithubRepoCopyWith(
          GithubRepo value, $Res Function(GithubRepo) then) =
      _$GithubRepoCopyWithImpl<$Res, GithubRepo>;
  @useResult
  $Res call(
      {User owner,
      String name,
      String fullName,
      String description,
      int stargazersCount});

  $UserCopyWith<$Res> get owner;
}

/// @nodoc
class _$GithubRepoCopyWithImpl<$Res, $Val extends GithubRepo>
    implements $GithubRepoCopyWith<$Res> {
  _$GithubRepoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? name = null,
    Object? fullName = null,
    Object? description = null,
    Object? stargazersCount = null,
  }) {
    return _then(_value.copyWith(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as User,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get owner {
    return $UserCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GithuRepoCopyWith<$Res>
    implements $GithubRepoCopyWith<$Res> {
  factory _$$_GithuRepoCopyWith(
          _$_GithuRepo value, $Res Function(_$_GithuRepo) then) =
      __$$_GithuRepoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User owner,
      String name,
      String fullName,
      String description,
      int stargazersCount});

  @override
  $UserCopyWith<$Res> get owner;
}

/// @nodoc
class __$$_GithuRepoCopyWithImpl<$Res>
    extends _$GithubRepoCopyWithImpl<$Res, _$_GithuRepo>
    implements _$$_GithuRepoCopyWith<$Res> {
  __$$_GithuRepoCopyWithImpl(
      _$_GithuRepo _value, $Res Function(_$_GithuRepo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? name = null,
    Object? fullName = null,
    Object? description = null,
    Object? stargazersCount = null,
  }) {
    return _then(_$_GithuRepo(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as User,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GithuRepo extends _GithuRepo {
  const _$_GithuRepo(
      {required this.owner,
      required this.name,
      required this.fullName,
      required this.description,
      required this.stargazersCount})
      : super._();

  @override
  final User owner;
  @override
  final String name;
  @override
  final String fullName;
  @override
  final String description;
  @override
  final int stargazersCount;

  @override
  String toString() {
    return 'GithubRepo(owner: $owner, name: $name, fullName: $fullName, description: $description, stargazersCount: $stargazersCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GithuRepo &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.stargazersCount, stargazersCount) ||
                other.stargazersCount == stargazersCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, owner, name, fullName, description, stargazersCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GithuRepoCopyWith<_$_GithuRepo> get copyWith =>
      __$$_GithuRepoCopyWithImpl<_$_GithuRepo>(this, _$identity);
}

abstract class _GithuRepo extends GithubRepo {
  const factory _GithuRepo(
      {required final User owner,
      required final String name,
      required final String fullName,
      required final String description,
      required final int stargazersCount}) = _$_GithuRepo;
  const _GithuRepo._() : super._();

  @override
  User get owner;
  @override
  String get name;
  @override
  String get fullName;
  @override
  String get description;
  @override
  int get stargazersCount;
  @override
  @JsonKey(ignore: true)
  _$$_GithuRepoCopyWith<_$_GithuRepo> get copyWith =>
      throw _privateConstructorUsedError;
}
