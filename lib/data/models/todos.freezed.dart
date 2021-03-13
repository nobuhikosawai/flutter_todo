// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'todos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$TodosTearOff {
  const _$TodosTearOff();

// ignore: unused_element
  _Todos call({@required List<Todo> items}) {
    return _Todos(
      items: items,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Todos = _$TodosTearOff();

/// @nodoc
mixin _$Todos {
  List<Todo> get items;

  @JsonKey(ignore: true)
  $TodosCopyWith<Todos> get copyWith;
}

/// @nodoc
abstract class $TodosCopyWith<$Res> {
  factory $TodosCopyWith(Todos value, $Res Function(Todos) then) =
      _$TodosCopyWithImpl<$Res>;
  $Res call({List<Todo> items});
}

/// @nodoc
class _$TodosCopyWithImpl<$Res> implements $TodosCopyWith<$Res> {
  _$TodosCopyWithImpl(this._value, this._then);

  final Todos _value;
  // ignore: unused_field
  final $Res Function(Todos) _then;

  @override
  $Res call({
    Object items = freezed,
  }) {
    return _then(_value.copyWith(
      items: items == freezed ? _value.items : items as List<Todo>,
    ));
  }
}

/// @nodoc
abstract class _$TodosCopyWith<$Res> implements $TodosCopyWith<$Res> {
  factory _$TodosCopyWith(_Todos value, $Res Function(_Todos) then) =
      __$TodosCopyWithImpl<$Res>;
  @override
  $Res call({List<Todo> items});
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
    Object items = freezed,
  }) {
    return _then(_Todos(
      items: items == freezed ? _value.items : items as List<Todo>,
    ));
  }
}

/// @nodoc
class _$_Todos extends _Todos with DiagnosticableTreeMixin {
  const _$_Todos({@required this.items})
      : assert(items != null),
        super._();

  @override
  final List<Todo> items;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Todos(items: $items)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Todos'))
      ..add(DiagnosticsProperty('items', items));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Todos &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(items);

  @JsonKey(ignore: true)
  @override
  _$TodosCopyWith<_Todos> get copyWith =>
      __$TodosCopyWithImpl<_Todos>(this, _$identity);
}

abstract class _Todos extends Todos {
  const _Todos._() : super._();
  const factory _Todos({@required List<Todo> items}) = _$_Todos;

  @override
  List<Todo> get items;
  @override
  @JsonKey(ignore: true)
  _$TodosCopyWith<_Todos> get copyWith;
}
