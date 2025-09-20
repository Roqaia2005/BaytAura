// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PropertyState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PropertyState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PropertyState()';
}


}

/// @nodoc
class $PropertyStateCopyWith<$Res>  {
$PropertyStateCopyWith(PropertyState _, $Res Function(PropertyState) __);
}


/// Adds pattern-matching-related methods to [PropertyState].
extension PropertyStatePatterns on PropertyState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PropertyInitial value)?  initial,TResult Function( PropertyLoading value)?  loading,TResult Function( PropertyLoaded value)?  loaded,TResult Function( PropertyError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PropertyInitial() when initial != null:
return initial(_that);case PropertyLoading() when loading != null:
return loading(_that);case PropertyLoaded() when loaded != null:
return loaded(_that);case PropertyError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PropertyInitial value)  initial,required TResult Function( PropertyLoading value)  loading,required TResult Function( PropertyLoaded value)  loaded,required TResult Function( PropertyError value)  error,}){
final _that = this;
switch (_that) {
case PropertyInitial():
return initial(_that);case PropertyLoading():
return loading(_that);case PropertyLoaded():
return loaded(_that);case PropertyError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PropertyInitial value)?  initial,TResult? Function( PropertyLoading value)?  loading,TResult? Function( PropertyLoaded value)?  loaded,TResult? Function( PropertyError value)?  error,}){
final _that = this;
switch (_that) {
case PropertyInitial() when initial != null:
return initial(_that);case PropertyLoading() when loading != null:
return loading(_that);case PropertyLoaded() when loaded != null:
return loaded(_that);case PropertyError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Property> properties,  List<Property> favorites)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PropertyInitial() when initial != null:
return initial();case PropertyLoading() when loading != null:
return loading();case PropertyLoaded() when loaded != null:
return loaded(_that.properties,_that.favorites);case PropertyError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Property> properties,  List<Property> favorites)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case PropertyInitial():
return initial();case PropertyLoading():
return loading();case PropertyLoaded():
return loaded(_that.properties,_that.favorites);case PropertyError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Property> properties,  List<Property> favorites)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case PropertyInitial() when initial != null:
return initial();case PropertyLoading() when loading != null:
return loading();case PropertyLoaded() when loaded != null:
return loaded(_that.properties,_that.favorites);case PropertyError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PropertyInitial implements PropertyState {
  const PropertyInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PropertyInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PropertyState.initial()';
}


}




/// @nodoc


class PropertyLoading implements PropertyState {
  const PropertyLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PropertyLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PropertyState.loading()';
}


}




/// @nodoc


class PropertyLoaded implements PropertyState {
  const PropertyLoaded({required final  List<Property> properties, required final  List<Property> favorites}): _properties = properties,_favorites = favorites;
  

 final  List<Property> _properties;
 List<Property> get properties {
  if (_properties is EqualUnmodifiableListView) return _properties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_properties);
}

 final  List<Property> _favorites;
 List<Property> get favorites {
  if (_favorites is EqualUnmodifiableListView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favorites);
}


/// Create a copy of PropertyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PropertyLoadedCopyWith<PropertyLoaded> get copyWith => _$PropertyLoadedCopyWithImpl<PropertyLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PropertyLoaded&&const DeepCollectionEquality().equals(other._properties, _properties)&&const DeepCollectionEquality().equals(other._favorites, _favorites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_properties),const DeepCollectionEquality().hash(_favorites));

@override
String toString() {
  return 'PropertyState.loaded(properties: $properties, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $PropertyLoadedCopyWith<$Res> implements $PropertyStateCopyWith<$Res> {
  factory $PropertyLoadedCopyWith(PropertyLoaded value, $Res Function(PropertyLoaded) _then) = _$PropertyLoadedCopyWithImpl;
@useResult
$Res call({
 List<Property> properties, List<Property> favorites
});




}
/// @nodoc
class _$PropertyLoadedCopyWithImpl<$Res>
    implements $PropertyLoadedCopyWith<$Res> {
  _$PropertyLoadedCopyWithImpl(this._self, this._then);

  final PropertyLoaded _self;
  final $Res Function(PropertyLoaded) _then;

/// Create a copy of PropertyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? properties = null,Object? favorites = null,}) {
  return _then(PropertyLoaded(
properties: null == properties ? _self._properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,favorites: null == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<Property>,
  ));
}


}

/// @nodoc


class PropertyError implements PropertyState {
  const PropertyError({required this.message});
  

 final  String message;

/// Create a copy of PropertyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PropertyErrorCopyWith<PropertyError> get copyWith => _$PropertyErrorCopyWithImpl<PropertyError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PropertyError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PropertyState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $PropertyErrorCopyWith<$Res> implements $PropertyStateCopyWith<$Res> {
  factory $PropertyErrorCopyWith(PropertyError value, $Res Function(PropertyError) _then) = _$PropertyErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PropertyErrorCopyWithImpl<$Res>
    implements $PropertyErrorCopyWith<$Res> {
  _$PropertyErrorCopyWithImpl(this._self, this._then);

  final PropertyError _self;
  final $Res Function(PropertyError) _then;

/// Create a copy of PropertyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PropertyError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
