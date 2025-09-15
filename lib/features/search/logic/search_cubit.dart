import 'search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/search/data/repos/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;

  SearchCubit(this.searchRepo) : super(const SearchState.initial());

  Future<void> search(String query) async {
    try {
      emit(const SearchState.loading());
      final results = await searchRepo.search(query);
      emit(SearchState.loaded(results));
    } catch (e) {
      emit(SearchState.error("Failed to search: $e"));
    }
  }

  Future<void> applyFilter({
    String? type,
    int? minPrice,
    int? maxPrice,
    int? rooms,
    int? minArea,
  }) async {
    try {
      emit(const SearchState.loading());
      final results = await searchRepo.applyFilter(
        type: type,
        minPrice: minPrice,
        maxPrice: maxPrice,
        rooms: rooms,
        minArea: minArea,
      );
      emit(SearchState.loaded(results));
    } catch (e) {
      emit(SearchState.error("Failed to filter: $e"));
    }
  }
}
