import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'me.freezed.dart';

@freezed
abstract class Me with _$Me {
  factory Me({
    @required String id,
    @Default('') String displayName,
  }) = _Me;
}
