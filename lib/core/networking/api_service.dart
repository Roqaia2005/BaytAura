import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:bayt_aura/core/networking/api_constants.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/auth/data/models/login_response.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_response.dart';
import 'package:bayt_aura/features/auth/data/models/login_request_body.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_request_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  //********AUTHENTICATION METHODS*********/
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

  //ADD PROPERTY **PROVIDER**
  @POST(ApiConstants.addProperty)
  Future<Property> addProperty(@Body() Property property);
  //***********SEARCH METHODS****************//
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
  //PROPERTY METHODS
  @GET(ApiConstants.fetchProperties)
  Future<List<Property>> fetchProperties();

  @GET("${ApiConstants.fetchPropertyById}{id}")
  Future<Property> fetchPropertyById(@Path("id") int id);

  @POST(ApiConstants.addFavorite)
  Future<void> addFavorite(@Path("id") int propertyId);

  @DELETE(ApiConstants.removeFavorite)
  Future<void> removeFavorite(@Path("id") int propertyId);

  @DELETE(ApiConstants.deleteProperty)
  Future<void> deleteProperty(@Query("propertyId") int propertyId);

  //ADMIN METHODS
  @PUT(ApiConstants.approveProvider)
  Future<void> approveProvider(@Path("providerId") int providerId);
  @GET(ApiConstants.getRequestByIdAdmin)
  Future<CustomerRequest> getRequestByIdAdmin(@Path("id") int id);
  @GET(ApiConstants.getCustomerRequests)
  Future<List<CustomerRequest>> getCustomerRequests(); // ADMIN
  @PUT(ApiConstants.changeRequestStatus)
  Future<void> changeRequestStatus(
    @Path("id") int id,
    @Query("status") String status,
  );
  @DELETE(ApiConstants.deleteRequest)
  Future<void> deleteRequestByAdmin(@Path("id") int id);
  //******************************************** */
  //CUSTOMER METHODS
  @POST(ApiConstants.createRequest)
  Future<CustomerRequest> createRequest(@Body() CustomerRequest requestBody);

  @GET(ApiConstants.getMyRequests)
  Future<List<CustomerRequest>> getMyRequests(); // CUSTOMER

  @GET(ApiConstants.getRequestByIdCustomer)
  Future<CustomerRequest> getRequestByIdCustomer(@Path("id") int id);

  @DELETE(ApiConstants.deleteMyRequest)
  Future<void> deleteMyRequest(@Path("id") int id); // CUSTOMER

  //PROFILE METHODS
  @GET(ApiConstants.getProfile)
  Future<void> getProfile();
  @PUT(ApiConstants.updateProfile)
  Future<void> updateProfile();

  @DELETE(ApiConstants.deleteProfile)
  Future<void> deleteProfile();

  @POST(ApiConstants.uploadProfilePicture)
  Future<void> uploadProfilePicture();
  @DELETE(ApiConstants.deleteProfilePicture)
  Future<void> deleteProfilePicture();

  //MEDIA
  @GET(ApiConstants.getAllMedia)
  Future<List<RequestImages>> getAllMedia(@Path("id") int propertyId);

  @GET(ApiConstants.getSingleMedia)
  Future<RequestImages> getSingleMedia(@Path("id") int mediaId);

  @DELETE(ApiConstants.deleteMedia)
  Future<void> deleteMedia(
    @Path("pId") int propertyId,
    @Path("mId") int mediaId,
  );

  @POST(ApiConstants.uploadMedia)
  @MultiPart()
  Future<RequestImages> uploadMedia(
    @Path("id") int propertyId,
    @Part(name: "file") File file,
    @Part(name: "altName") String altName,
  );
}
