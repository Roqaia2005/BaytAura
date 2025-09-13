import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';

part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit()
      : super(PropertyLoaded(properties: const [], favorites: const []));

  final List<Property> _allProperties = [];
  final List<Property> _favorites = [];
  final List<Property> _userProperties = []; // 🆕 اللي بيضيفها المستخدم

  // 🏠 تحميل كل العقارات (من API أو Mock)
  void loadProperties(List<Property> properties) {
    _allProperties
      ..clear()
      ..addAll(properties);
    _emitLoaded();
  }

  // ➕ إضافة عقار جديد من المستخدم
  void addProperty(Property property) {
    _userProperties.add(property);
    _allProperties.add(property); // يدخل في القائمة العامة كمان
    _emitLoaded();
  }

  // ⭐ إضافة / إزالة من المفضلة
  void toggleFavorite(Property property) {
    if (_favorites.contains(property)) {
      _favorites.remove(property);
    } else {
      _favorites.add(property);
    }
    _emitLoaded();
  }

  void _emitLoaded() {
    emit(PropertyLoaded(
      properties: List.from(_allProperties),
      favorites: List.from(_favorites),
    ));
  }
}
