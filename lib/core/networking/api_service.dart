import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:bayt_aura/core/networking/api_constants.dart';
import 'package:bayt_aura/features/auth/data/models/login_response.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_response.dart';
import 'package:bayt_aura/features/auth/data/models/login_request_body.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_request_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.registerCustomer)
  Future<SignupResponse> signupCustomer(@Body() SignupRequestBody signupRequestBody);


  @POST(ApiConstants.registerAdmin)
  Future<SignupResponse> signupAdmin(@Body() SignupRequestBody signupRequestBody);

  @POST(ApiConstants.registerProvider)
  Future<SignupResponse> signupProvider(@Body() SignupRequestBody signupRequestBody);
}