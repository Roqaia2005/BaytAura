import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/property/logic/media_states.dart';
import 'package:bayt_aura/features/property/data/models/media_repo.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

class MediaCubit extends Cubit<MediaState> {
  final MediaRepository repo;

  MediaCubit(this.repo) : super(const MediaState.initial());

  Future<void> loadMedia(int propertyId) async {
    emit(const MediaState.loading());
    try {
      final mediaList = await repo.fetchAllMedia(propertyId);
      emit(MediaState.loaded(mediaList));
    } catch (e) {
      emit(MediaState.error(e.toString()));
    }
  }

  Future<void> addMedia(int propertyId, File file) async {
    try {
      final uploaded = await repo.uploadMedia(propertyId, file);

      state.maybeWhen(
        loaded: (media) {
          final updatedList = List<RequestImages>.from(media)..add(uploaded);
          emit(MediaState.loaded(updatedList));
        },
        orElse: () => emit(MediaState.uploaded(uploaded)),
      );
    } catch (e) {
      emit(MediaState.error(e.toString()));
    }
  }

  Future<void> deleteMedia(int propertyId, int mediaId) async {
    try {
      await repo.deleteMedia(propertyId, mediaId);

      state.maybeWhen(
        loaded: (media) {
          final updatedList = media.where((img) => img.id != mediaId).toList();
          emit(MediaState.loaded(updatedList));
        },
        orElse: () {},
      );
    } catch (e) {
      emit(MediaState.error(e.toString()));
    }
  }
}
