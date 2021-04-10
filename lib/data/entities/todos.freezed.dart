// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'todos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TodosTearOff {
  const _$TodosTearOff();

  _Todos call(
      {required List<Todo> uncompletedItems,
      required List<Todo> completedItems}) {
    return _Todos(
      uncompletedItems: uncompletedItems,
      completedItems: completedItems,
    );
  }
}

/// @nodoc
const $Todos = _$TodosTearOff();

/// @nodoc
mixin _$Todos {
  List<Todo> get uncompletedItems => throw _privateConstructorUsedError;
  List<Todo> get completedItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodosCopyWith<Todos> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodosCopyWith<$Res> {
  factory $TodosCopyWith(Todos value, $Res Function(Todos) then) =
      _$TodosCopyWithImpl<$Res>;
  $Res call({List<Todo> uncompletedItems, List<Todo> completedItems});
}

/// @nodoc
class _$TodosCopyWithImpl<$Res> implements $TodosCopyWith<$Res> {
  _$TodosCopyWithImpl(this._value, this._then);

  final Todos _value;
  // ignore: unused_field
  final $Res Function(Todos) _then;

  @override
  $Res call({
    Object? uncompletedItems = freezed,
    Object? completedItems = freezed,
  }) {
    return _then(_value.copyWith(
      uncompletedItems: uncompletedItems == freezed
          ? _value.uncompletedItems
          : uncompletedItems // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      completedItems: completedItems == freezed
          ? _value.completedItems
          : completedItems // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

/// @nodoc
abstract class _$TodosCopyWith<$Res> implements $TodosCopyWith<$Res> {
  factory _$TodosCopyWith(_Todos value, $Res Function(_Todos) then) =
      __$TodosCopyWithImpl<$Res>;
  @override
  $Res call({List<Todo> uncompletedItems, List<Todo> completedItems});
}

/// @nodoc
class __$TodosCopyWithImpl<$Res> extends _$TodosCopyWithImpl<$Res>
    implements _$TodosCopyWith<$Res> {
  __$TodosCopyWithImpl(_Todos _value, $Res Function(_Todos) _then)
      : super(_value, (v) => _then(v as _Todos));

  @override
  _Todos get _value => super._value as _Todos;

  @override
  $Res call({
    Object? uncompletedItems = freezed,
    Object? completedItems = freezed,
  }) {
    return _then(_Todos(
      uncompletedItems: uncompletedItems == freezed
          ? _value.uncompletedItems
          : uncompletedItems // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      completedItems: completedItems == freezed
          ? _value.completedItems
          : completedItems // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

/// @nodoc
class _$_Todos extends _Todos with DiagnosticableTreeMixin {
  const _$_Todos({required this.uncompletedItems, required this.completedItems})
      : super._();

  @override
  final List<Todo> uncompletedItems;
  @override
  final List<Todo> completedItems;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Todos(uncompletedItems: $uncompletedItems, completedItems: $completedItems)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Todos'))
      ..add(DiagnosticsProperty('uncompletedItems', uncompletedItems))
      ..add(DiagnosticsProperty('completedItems', completedItems));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Todos &&
            (identical(other.uncompletedItems, uncompletedItems) ||
                const DeepCollectionEquality()
                    .equals(other.uncompletedItems, uncompletedItems)) &&
            (identical(other.completedItems, completedItems) ||
                const DeepCollectionEquality()
                    .equals(other.completedItems, completedItems)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uncompletedItems) ^
      const DeepCollectionEquality().hash(completedItems);

  @JsonKey(ignore: true)
  @override
  _$TodosCopyWith<_Todos> get copyWith =>
      __$TodosCopyWithImpl<_Todos>(this, _$identity);
}

abstract class _Todos extends Todos {
  const factory _Todos(
      {required List<Todo> uncompletedItems,
      required List<Todo> completedItems}) = _$_Todos;
  const _Todos._() : super._();

  @override
  List<Todo> get uncompletedItems => throw _privateConstructorUsedError;
  @override
  List<Todo> get completedItems => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TodosCopyWith<_Todos> get copyWith => throw _privateConstructorUsedError;
}
