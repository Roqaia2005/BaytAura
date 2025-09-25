import 'package:bayt_aura/features/customer/data/models/customer_request.dart';
import 'package:bayt_aura/features/provider/data/models/provider_request.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

/// -------- Customer Requests ----------
class CustomerRequestsLoaded extends AdminState {
  final List<CustomerRequest> requests;
  CustomerRequestsLoaded(this.requests);
}

/// -------- Provider Requests ----------
class ProviderRequestsLoaded extends AdminState {
  final List<ProviderRequest> requests;
  ProviderRequestsLoaded(this.requests);
}

/// -------- Single Request ----------
class SingleRequestLoaded extends AdminState {
  final CustomerRequest request;
  SingleRequestLoaded(this.request);
}

/// -------- Approval / Updates ----------
class ProviderApproved extends AdminState {
  final String message;
  ProviderApproved(this.message);
}

class RequestStatusChanged extends AdminState {
  final String message;
  RequestStatusChanged(this.message);
}

class RequestDeleted extends AdminState {
  final String message;
  RequestDeleted(this.message);
}

/// -------- Error ----------
class AdminError extends AdminState {
  final String message;
  AdminError(this.message);
}
