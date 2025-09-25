import 'search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/search/data/repos/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;

  SearchCubit(this.searchRepo) : super(const SearchState.initial());

  Future<void> searchOrFilter({
    String? query,
    String? type,
    int? minPrice,
    int? maxPrice,

    int? minArea,
    int? maxArea,
    String? owner,
    String? purpose,
  }) async {
    try {
      emit(const SearchState.loading());
      final results = await searchRepo.getProperties(
        query: query,
        type: type,
        minPrice: minPrice,
        maxPrice: maxPrice,

        minArea: minArea,
        maxArea: maxArea,
        owner: owner,
        purpose: purpose,
      );
      emit(SearchState.loaded(results));
    } catch (e) {
      emit(SearchState.error("Failed to fetch properties: $e"));
    }
  }
}
