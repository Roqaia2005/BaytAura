import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:bayt_aura/core/networking/api_constants.dart';
import 'package:bayt_aura/features/profile/data/models/profile.dart';
import 'package:bayt_aura/features/property/data/models/favorite.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/auth/data/models/login_response.dart';
import 'package:bayt_aura/features/auth/data/models/sign_up_response.dart';
import 'package:bayt_aura/features/auth/data/models/login_request_body.dart';
import 'package:bayt_aura/features/provider/data/models/provider_request.dart';
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
  @MultiPart()
  Future<Property> addProperty(
    @Part(name: "title") String title,
    @Part(name: "type") String type,
    @Part(name: "purpose") String purpose,
    @Part(name: "description") String description,
    @Part(name: "price") double price,
    @Part(name: "area") double area,
    @Part(name: "address") String address,
    @Part(name: "latitude") double latitude,
    @Part(name: "longitude") double longitude,
    @Part(name: "files") List<MultipartFile>? files,
  );

  //***********SEARCH METHODS****************//
  @GET(ApiConstants.fetchProperties)
  Future<List<Property>> getProperties({
    @Query("searchQuery") String? query,
    @Query("type") String? type,
    @Query("minPrice") int? minPrice,
    @Query("maxPrice") int? maxPrice,
    @Query("minArea") int? minArea,
    @Query("maxArea") int? maxArea,

    @Query("owner") String? owner,
    @Query("purpose") String? purpose,
  });

  //PROPERTY METHODS
  @GET(ApiConstants.fetchProperties)
  Future<List<Property>> fetchProperties();
  @GET(ApiConstants.getMyProperties)
  Future<List<Property>> getMyProperties();
  //PROPERTY METHODS
  @GET(ApiConstants.myFavorites)
  Future<List<Favorite>> fetchMyFavorites();

  @GET(ApiConstants.fetchPropertyById)
  Future<Property> fetchPropertyById(@Path("id") int id);

  @POST(ApiConstants.addFavorite)
  Future<void> addFavorite(@Path("id") int propertyId);

  @DELETE(ApiConstants.removeFavorite)
  Future<void> removeFavorite(@Path("id") int favoriteId);

  @DELETE(ApiConstants.deleteMyProperty)
  Future<void> deleteMyProperty(@Path("propertyId") int propertyId);

  @PUT(ApiConstants.updateMyProperty)
  Future<Property> updateMyProperty(
    @Path("id") int propertyId,
    @Body() Map<String, dynamic> body,
  );

  //ADMIN METHODS
  @PUT(ApiConstants.approveProvider)
  Future<void> approveProvider(
    @Path("id") int providerId,
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.getRequestByIdAdmin)
  Future<CustomerRequest> getRequestByIdAdmin(@Path("id") int id);
  @GET(ApiConstants.getCustomerRequests)
  Future<List<CustomerRequest>> getCustomerRequests(); // ADMIN
  @GET(ApiConstants.getProviderRequests)
  Future<List<ProviderRequest>> getProviderRequests(); // ADMIN
  @PUT(ApiConstants.changeRequestStatus)
  Future<void> changeRequestStatus(
    @Path("id") int id,
    @Body() Map<String, String> body,
  );

  @DELETE(ApiConstants.deleteProperty)
  Future<void> deleteProperty(@Path("propertyId") int propertyId);

  @DELETE(ApiConstants.deleteRequest)
  Future<void> deleteRequestByAdmin(@Path("id") int id);
  //******************************************** */
  //CUSTOMER METHODS
  @POST(ApiConstants.createRequest)
  @MultiPart()
  Future<CustomerRequest> createRequest(
    @Part(name: "title") String title,
    @Part(name: "type") String type,
    @Part(name: "purpose") String purpose,
    @Part(name: "description") String description,
    @Part(name: "price") double price,
    @Part(name: "area") double area,
    @Part(name: "address") String address,
    @Part(name: "latitude") double latitude,
    @Part(name: "longitude") double longitude,
    @Part(name: "files") List<MultipartFile>? files,
  );

  @GET(ApiConstants.getMyRequests)
  Future<List<CustomerRequest>> getMyRequests(); // CUSTOMER

  @GET(ApiConstants.getRequestByIdCustomer)
  Future<CustomerRequest> getRequestByIdCustomer(@Path("id") int id);

  @DELETE(ApiConstants.deleteMyRequest)
  Future<void> deleteMyRequest(@Path("id") int id); // CUSTOMER

  //PROFILE METHODS
  @GET(ApiConstants.getProfile)
  Future<Profile> getProfile();
  @PUT(ApiConstants.updateProfile)
  Future<Profile> updateProfile(@Body() Map<String, dynamic> body);

  @DELETE(ApiConstants.deleteProfile)
  Future<void> deleteProfile();

  @PUT(ApiConstants.uploadProfilePicture)
  @MultiPart()
  Future<void> uploadProfilePicture(@Part(name: "file") MultipartFile file);

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
