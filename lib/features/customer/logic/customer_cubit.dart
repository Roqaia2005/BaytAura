import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/customer/logic/customer_state.dart';
import 'package:bayt_aura/features/customer/data/repo/customer_repo.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

class CustomerRequestCubit extends Cubit<CustomerRequestState> {
  final CustomerRepo _customerRepo;

  CustomerRequestCubit(this._customerRepo) : super(CustomerRequestInitial());

  /// Create a new request
  Future<int?> createRequest(CustomerRequest request) async {
    emit(CustomerRequestLoading());
    try {
      final createdRequest = await _customerRepo.createRequest(request);

      // Emit the added request state once
      emit(CustomerRequestAdded(request: createdRequest));

      // Refresh my requests to update the UI
      await getMyRequests();

      return createdRequest.id;
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
      return null;
    }
  }

  /// Get current user's requests
  /// Get current user's requests
  List<CustomerRequest> _previousRequests = [];

  Future<void> getMyRequests() async {
    emit(CustomerRequestLoading());
    try {
      final requests = await _customerRepo.getMyRequests();

      // Compare old vs new for status changes
      for (var newReq in requests) {
        final oldReq = _previousRequests.firstWhere(
          (r) => r.id == newReq.id,
          orElse: () => newReq,
        );

        if (oldReq.status != newReq.status) {
          emit(
            RequestStatusChanged(
              "Your request '${newReq.title}' status changed to ${newReq.status}",
            ),
          );
        }
      }

      _previousRequests = requests;
      emit(CustomerRequestsLoaded(requests));
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
    }
  }

  /// Delete request
  Future<void> deleteRequest(int id) async {
    emit(CustomerRequestLoading());
    try {
      await _customerRepo.deleteRequest(id);
      emit(CustomerRequestSuccess("Request deleted successfully"));
      await getMyRequests(); // refresh list
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
    }
  }
}
