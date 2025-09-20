import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

class CustomerRepo {
  final ApiService apiService;

  CustomerRepo({required this.apiService});

  /// Create a new CustomerRequest(e.g., property request)
  Future<CustomerRequest> createRequest(CustomerRequest request) {
    // Convert Customer request model to Map<String, dynamic> for API

    return apiService.createRequest(request);
  }

  /// Get all requests of the logged-in customer
  Future<List<CustomerRequest>> getMyRequests() {
    return apiService.getMyRequests();
  }

  /// Get a single Customer request by ID
  Future<CustomerRequest> getRequestById(int requestId) {
    return apiService.getRequestByIdCustomer(requestId);
  }

  /// Delete a Customer request by ID
  Future<void> deleteRequest(int requestId) {
    return apiService.deleteMyRequest(requestId);
  }
}
