import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:bayt_aura/core/networking/api_constants.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';
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
  Future<SignupResponse> signupCustomer(
    @Body() SignupRequestBody signupRequestBody,
  );

  @POST(ApiConstants.registerAdmin)
  Future<SignupResponse> signupAdmin(
    @Body() SignupRequestBody signupRequestBody,
  );

  @POST(ApiConstants.registerProvider)
  Future<SignupResponse> signupProvider(
    @Body() SignupRequestBody signupRequestBody,
  );
  @POST(ApiConstants.addProperty)
  Future<Property> addProperty(@Body() Property property);

  @GET(ApiConstants.searchProperties)
  Future<List<Property>> searchProperties(@Query("q") String query);

  @GET(ApiConstants.filterProperties)
  Future<List<Property>> filterProperties({
    @Query("type") String? type,
    @Query("minPrice") int? minPrice,
    @Query("maxPrice") int? maxPrice,
    @Query("rooms") int? rooms,
    @Query("minArea") int? minArea,
  });

  @GET(ApiConstants.fetchProperties)
  Future<List<Property>> fetchProperties();

  @GET("${ApiConstants.fetchPropertyById}{id}")
  Future<Property> fetchPropertyById(@Path("id") String id);

  @POST(ApiConstants.addFavorite)
  Future<void> addFavorite(@Query("propertyId") String propertyId);

  @DELETE(ApiConstants.removeFavorite)
  Future<void> removeFavorite(@Query("propertyId") String propertyId);
}
