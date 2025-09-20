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

  Future<void> createRequest(CustomerRequest request, {List<String>? imagePaths}) async {
    try {
      emit(CustomerRequestLoading());

      // Step 1: Create request
      final createdRequest = await _customerRepo.createRequest(request);

      // Step 2: Upload media if exists
      if (createdRequest.id != null && imagePaths != null && imagePaths.isNotEmpty) {
        for (final path in imagePaths) {
          final file = File(path);
          if (!file.existsSync()) continue;

          try {
            await _mediaRepo.uploadMedia(createdRequest.id!, file);
          } catch (e) {
            // Continue uploading next images, but report the error
            emit(CustomerRequestError("Image upload failed: ${e.toString()}"));
          }
        }
      }

      emit(CustomerRequestSuccess("Request created successfully"));
    } catch (e) {
      emit(CustomerRequestError(e.toString()));
    }
  }
}
