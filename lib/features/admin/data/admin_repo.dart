import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';


class AdminRepository {
  final ApiService _apiService;

  AdminRepository(this._apiService);

  /// Approve a provider account
  Future<void> approveProvider(int providerId) {
    return _apiService.approveProvider(providerId);
  }

  /// Change the status of a request (pending/confirmed/rejected)
  Future<void> changeRequestStatus(int requestId, String status) {
    return _apiService.changeRequestStatus(requestId, status);
  }

  /// Get all requests (customer requests)
  Future<List<CustomerRequest>> getAllRequests() {
    return _apiService.getAllRequests();
  }

  /// Get a specific request by ID (admin view)
  Future<CustomerRequest> getRequestByIdAdmin(int requestId) {
    return _apiService.getRequestByIdAdmin(requestId);
  }

  /// Delete a request by admin
  Future<void> deleteRequest(int requestId) {
    return _apiService.deleteRequestByAdmin(requestId);
  }
}
