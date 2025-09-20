import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestLoaded extends RequestState {
  final List<CustomerRequest> requests;
  RequestLoaded(this.requests);
}

class SingleRequestLoaded extends RequestState {
  final CustomerRequest request;
  SingleRequestLoaded(this.request);
}

class RequestError extends RequestState {
  final String message;
  RequestError(this.message);
}

class RequestSuccess extends RequestState {
  final String message;
  RequestSuccess(this.message);
}