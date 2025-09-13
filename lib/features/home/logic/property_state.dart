part of 'property_cubit.dart';

abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final List<Property> properties;
  final List<Property> favorites;

  PropertyLoaded({
    required this.properties,
    required this.favorites,
  });
}
