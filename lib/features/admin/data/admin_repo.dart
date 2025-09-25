import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';
import 'package:bayt_aura/features/provider/data/models/provider_request.dart';

class AdminRepository {
  final ApiService _apiService;

  AdminRepository(this._apiService);

  /// Approve a provider account
  Future<void> approveProvider(int providerId, String status) {
    return _apiService.approveProvider(providerId, {"status": status});
  }

  /// Change the status of a request (pending/confirmed/rejected)
  Future<void> changeRequestStatus(int id, String status) {
    return _apiService.changeRequestStatus(id, {"status": status});
  }

  /// Get all requests (customer requests)
  Future<List<CustomerRequest>> getCustomerRequests() {
    return _apiService.getCustomerRequests();
  }

  Future<List<ProviderRequest>> getProviderRequests() {
    return _apiService.getProviderRequests();
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
