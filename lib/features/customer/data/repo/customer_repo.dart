import 'package:dio/dio.dart';
import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

class CustomerRepo {
  final ApiService apiService;

  CustomerRepo({required this.apiService});

  Future<CustomerRequest> createRequest(CustomerRequest request) async {
    List<MultipartFile>? files;
    if (request.files != null && request.files!.isNotEmpty) {
      files = request.files!
          .map((f) => MultipartFile.fromFileSync(f.path))
          .toList();
    }

    final createdRequest = await apiService.createRequest(
      request.title,
      request.type,
      request.purpose,
      request.description,
      request.price,
      request.area,
      request.address,
      request.latitude,
      request.longitude,
      files,
    );

    return createdRequest;
  }

  Future<List<CustomerRequest>> getMyRequests() {
    return apiService.getMyRequests();
  }

  Future<CustomerRequest> getRequestById(int requestId) {
    return apiService.getRequestByIdCustomer(requestId);
  }

  Future<void> deleteRequest(int requestId) {
    return apiService.deleteMyRequest(requestId);
  }
}
