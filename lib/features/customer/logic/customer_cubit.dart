import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/customer/logic/customer_state.dart';
import 'package:bayt_aura/features/property/data/repos/media_repo.dart';
import 'package:bayt_aura/features/customer/data/repo/customer_repo.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

class CustomerRequestCubit extends Cubit<CustomerRequestState> {
  final CustomerRepo _customerRepo;
  final MediaRepository _mediaRepo;

  CustomerRequestCubit(this._customerRepo, this._mediaRepo)
    : super(CustomerRequestInitial());

  /// Create a new request
  Future<int?> createRequest(
    CustomerRequest request, {
    List<String>? imagePaths,
  }) async {
    emit(CustomerRequestLoading());
    try {
      final createdRequest = await _customerRepo.createRequest(request);

      if (createdRequest.id == null) {
        emit(CustomerRequestError("Failed to create request: missing ID"));
        return null;
      }

      final requestId = createdRequest.id!;
      List<String> uploadErrors = [];

      if (imagePaths != null && imagePaths.isNotEmpty) {
        for (final path in imagePaths) {
          final file = File(path);
          if (!file.existsSync()) continue;
          try {
            await _mediaRepo.uploadMedia(requestId, file);
          } catch (e) {
            uploadErrors.add(file.path);
          }
        }
      }

      if (uploadErrors.isNotEmpty) {
        emit(
          CustomerRequestSuccess(
            "Request created, but some images failed: ${uploadErrors.length}",
          ),
        );
      } else {
        emit(CustomerRequestSuccess("Request created successfully"));
      }

      return requestId;
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
      return null;
    }
  }

  /// Get current user's requests
  Future<void> getMyRequests() async {
    emit(CustomerRequestLoading());
    try {
      final requests = await _customerRepo.getMyRequests();
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
