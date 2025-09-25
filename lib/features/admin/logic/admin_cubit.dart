import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/admin/data/admin_repo.dart';
import 'package:bayt_aura/features/admin/logic/admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository _repository;

  AdminCubit(this._repository) : super(AdminInitial());

  /// Approve provider
Future<void> approveProvider(int id, String status) async {
  try {
    emit(AdminLoading());
    await _repository.approveProvider(id, status); // pass status
    emit(ProviderApproved("Provider $status successfully"));
  } catch (e) {
    emit(AdminError(e.toString()));
  }
}


  /// Change request status (property/customer request)
  Future<void> changeRequestStatus(int id, String status) async {
    try {
      emit(AdminLoading());
      await _repository.changeRequestStatus(id, status);
      emit(RequestStatusChanged("Request status updated successfully"));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  /// Get all customer requests
  Future<void> getCustomerRequests() async {
    try {
      emit(AdminLoading());
      final requests = await _repository.getCustomerRequests();
      emit(CustomerRequestsLoaded(requests));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  /// Get all provider requests
  Future<void> getProviderRequests() async {
    try {
      emit(AdminLoading());
      final requests = await _repository.getProviderRequests();
      emit(ProviderRequestsLoaded(requests));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  /// Get single request by ID
  Future<void> getRequestById(int id) async {
    try {
      emit(AdminLoading());
      final request = await _repository.getRequestByIdAdmin(id);
      emit(SingleRequestLoaded(request));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  /// Delete request
  Future<void> deleteRequest(int id) async {
    try {
      emit(AdminLoading());
      await _repository.deleteRequest(id);
      emit(RequestDeleted("Request deleted successfully"));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }
}
