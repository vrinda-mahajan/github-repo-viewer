import 'package:freezed_annotation/freezed_annotation.dart';

part 'fresh.freezed.dart';

@freezed
class Fresh<T> with _$Fresh<T> {
  const Fresh._();
  const factory Fresh({
    required T entity,
    required bool isFresh,
    bool? isNextPageAvailable,
  }) = _Fresh<T>;

  factory Fresh.no(T entity, {bool? isNextPageAvailable}) {
    return Fresh(
      entity: entity,
      isFresh: false,
      isNextPageAvailable: isNextPageAvailable,
    );
  }

  factory Fresh.yes(T entity, {bool? isNextPageAvailable}) {
    return Fresh(
      entity: entity,
      isFresh: true,
      isNextPageAvailable: isNextPageAvailable,
    );
  }
}
