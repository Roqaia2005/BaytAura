import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/admin/data/admin_repo.dart';
import 'package:bayt_aura/features/admin/logic/request_state.dart';



class AdminCubit extends Cubit<RequestState> {
  final AdminRepository _repository;

  AdminCubit(this._repository) : super(RequestInitial());

  /// Approve provider
  void approveProvider(int id) async {
    try {
      emit(RequestLoading());
      await _repository.approveProvider(id);
      emit(RequestSuccess("Provider approved successfully"));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  /// Change request status (property request)
  void changeRequestStatus(int id, String status) async {
    try {
      emit(RequestLoading());
      await _repository.changeRequestStatus(id, status);
      emit(RequestSuccess("Request status updated successfully"));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  /// Get all requests
  void getAllRequests() async {
    try {
      emit(RequestLoading());
      final requests = await _repository.getAllRequests();
      emit(RequestLoaded(requests));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  /// Get single request by ID
  void getRequestById(int id) async {
    try {
      emit(RequestLoading());
      final request = await _repository.getRequestByIdAdmin(id);
      emit(SingleRequestLoaded(request));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  // /// Delete request by admin
  // void deleteRequest(int id) async {
  //   try {
  //     emit(RequestLoading());
  //     await _repository.deleteRequest(id);
  //     emit(RequestSuccess("Request deleted successfully"));
  //   } catch (e) {
  //     emit(RequestError(e.toString()));
  //   }
  // }
}
