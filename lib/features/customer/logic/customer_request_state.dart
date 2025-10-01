import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

abstract class CustomerRequestState {}

class CustomerRequestInitial extends CustomerRequestState {}

class CustomerRequestLoading extends CustomerRequestState {}

class CustomerRequestsLoaded extends CustomerRequestState {
  final List<CustomerRequest> requests;
  CustomerRequestsLoaded(this.requests);
}

class CustomerRequestLoaded extends CustomerRequestState {
  final CustomerRequest request;
  CustomerRequestLoaded(this.request);
}

class CustomerRequestAdded extends CustomerRequestState {
  final CustomerRequest request;
  final List<String> uploadErrors;

  CustomerRequestAdded({required this.request, this.uploadErrors = const []});
}

class CustomerRequestSuccess extends CustomerRequestState {
  final String message;
  CustomerRequestSuccess(this.message);
}

class CustomerRequestError extends CustomerRequestState {
  final String message;
  CustomerRequestError(this.message);
}

class RequestStatusChanged extends CustomerRequestState {
  final String message;
  RequestStatusChanged(this.message);
}
