import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/networking/recommendation_system.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';



abstract class RecommendationState {}

class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationLoaded extends RecommendationState {
  final List<Property> properties;
  RecommendationLoaded(this.properties);
}

class RecommendationError extends RecommendationState {
  final String message;
  RecommendationError(this.message);
}

class RecommendationCubit extends Cubit<RecommendationState> {
  final RecommendationService service;
  RecommendationCubit(this.service) : super(RecommendationInitial());

  Future<void> fetchLocationBased(int propertyId, {int limit = 5}) async {
    emit(RecommendationLoading());
    try {
      final props = await service.getLocationBasedRecommendations(propertyId, limit: limit);
      emit(RecommendationLoaded(props));
    } catch (e) {
      emit(RecommendationError(e.toString()));
    }
  }

  Future<void> fetchPriceBased(int propertyId, {int limit = 5}) async {
    emit(RecommendationLoading());
    try {
      final props = await service.getPriceBasedRecommendations(propertyId, limit: limit);
      emit(RecommendationLoaded(props));
    } catch (e) {
      emit(RecommendationError(e.toString()));
    }
  }

  Future<void> fetchUserBased(int userId, {int limit = 5}) async {

    emit(RecommendationLoading());
    try {

      final props = await service.getUserBasedRecommendations(userId, limit: limit);
      emit(RecommendationLoaded(props));
    } catch (e) {
      emit(RecommendationError(e.toString()));
    }
  }
}
