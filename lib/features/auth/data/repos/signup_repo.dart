import 'package:bayt_aura/core/networking/api_result.dart';
import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/core/networking/api_error_handler.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_response.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_request_body.dart';


class SignupRepo {
  final ApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignupResponse>> signup(
      SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiService.signupCustomer(signupRequestBody);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }
}