// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'me.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MeTearOff {
  const _$MeTearOff();

  _Me call({required String id, String? displayName = ''}) {
    return _Me(
      id: id,
      displayName: displayName,
    );
  }
}

/// @nodoc
const $Me = _$MeTearOff();

/// @nodoc
mixin _$Me {
  String get id => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MeCopyWith<Me> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeCopyWith<$Res> {
  factory $MeCopyWith(Me value, $Res Function(Me) then) =
      _$MeCopyWithImpl<$Res>;
  $Res call({String id, String? displayName});
}

/// @nodoc
class _$MeCopyWithImpl<$Res> implements $MeCopyWith<$Res> {
  _$MeCopyWithImpl(this._value, this._then);

  final Me _value;
  // ignore: unused_field
  final $Res Function(Me) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$MeCopyWith<$Res> implements $MeCopyWith<$Res> {
  factory _$MeCopyWith(_Me value, $Res Function(_Me) then) =
      __$MeCopyWithImpl<$Res>;
  @override
  $Res call({String id, String? displayName});
}

/// @nodoc
class __$MeCopyWithImpl<$Res> extends _$MeCopyWithImpl<$Res>
    implements _$MeCopyWith<$Res> {
  __$MeCopyWithImpl(_Me _value, $Res Function(_Me) _then)
      : super(_value, (v) => _then(v as _Me));

  @override
  _Me get _value => super._value as _Me;

  @override
  $Res call({
    Object? id = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_Me(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
class _$_Me with DiagnosticableTreeMixin implements _Me {
  _$_Me({required this.id, this.displayName = ''});

  @override
  final String id;
  @JsonKey(defaultValue: '')
  @override
  final String? displayName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Me(id: $id, displayName: $displayName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Me'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('displayName', displayName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Me &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(displayName);

  @JsonKey(ignore: true)
  @override
  _$MeCopyWith<_Me> get copyWith => __$MeCopyWithImpl<_Me>(this, _$identity);
}

abstract class _Me implements Me {
  factory _Me({required String id, String? displayName}) = _$_Me;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String? get displayName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MeCopyWith<_Me> get copyWith => throw _privateConstructorUsedError;
}
