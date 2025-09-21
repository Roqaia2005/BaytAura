import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/customer/logic/customer_state.dart';
import 'package:bayt_aura/features/property/data/models/media_repo.dart';
import 'package:bayt_aura/features/customer/data/repo/customer_repo.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';


class CustomerRequestCubit extends Cubit<CustomerRequestState> {
  final CustomerRepo _customerRepo;
  final MediaRepository _mediaRepo;

  CustomerRequestCubit(this._customerRepo, this._mediaRepo)
      : super(CustomerRequestInitial());

Future<int?> createRequest(CustomerRequest request, {List<String>? imagePaths}) async {
  try {
    emit(CustomerRequestLoading());

    // Step 1: Create request
    final createdRequest = await _customerRepo.createRequest(request);

    if (createdRequest.id == null) {
      emit( CustomerRequestError("Failed to create request: missing ID"));
      return null;
    }

    final requestId = createdRequest.id!;

    // Step 2: Upload media (optional)
    if (imagePaths != null && imagePaths.isNotEmpty) {
      for (final path in imagePaths) {
        final file = File(path);
        if (!file.existsSync()) continue;

        try {
          await _mediaRepo.uploadMedia(requestId, file);
        } catch (e) {
          // report error but don't stop the loop
          emit(CustomerRequestError("Image upload failed: ${e.toString()}"));
        }
      }
    }

    emit( CustomerRequestSuccess("Request created successfully"));
    return requestId; // مهم ترجعي الـ id
  } catch (e) {
    emit(CustomerRequestError(e.toString()));
    return null;
  }
}

}


