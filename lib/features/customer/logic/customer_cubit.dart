import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/customer/logic/customer_state.dart';
import 'package:bayt_aura/features/customer/data/repo/customer_repo.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

/// Cubit
class CustomerRequestCubit extends Cubit<CustomerRequestState> {
  final CustomerRepo _repository;

  CustomerRequestCubit(this._repository) : super(CustomerRequestInitial());

  /// Create a new request
  void createRequest(CustomerRequest request) async {
    try {
      emit(CustomerRequestLoading());
      await _repository.createRequest(request);
      emit(CustomerRequestSuccess("Request created successfully"));
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
    }
  }

  /// Get all requests of the customer
  void getMyRequests() async {
    try {
      emit(CustomerRequestLoading());
      final requests = await _repository.getMyRequests();
      emit(CustomerRequestsLoaded(requests));
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
    }
  }

  /// Get a single request by ID
  void getRequestById(int id) async {
    try {
      emit(CustomerRequestLoading());
      final request = await _repository.getRequestById(id);
      emit(CustomerRequestLoaded(request));
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
    }
  }

  /// Delete a request
  void deleteRequest(int id) async {
    try {
      emit(CustomerRequestLoading());
      await _repository.deleteRequest(id);
      emit(CustomerRequestSuccess("Request deleted successfully"));
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
    }
  }
}
