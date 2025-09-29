class ApiConstants {
  static const String baseUrl = "http://192.168.1.8:8080/api/";
  static const String chatbaseUrl = "http://127.0.0.1:8000/api/";
  static const String login = 'auth/login';
  static const String registerCustomer = 'auth/register/customer';
  static const String registerAdmin = 'auth/register/admin';
  static const String registerProvider = 'auth/register/provider';
  static const String addProperty = 'properties';

  static const String fetchProperties = 'properties';

  static const String fetchPropertyById = 'properties/'; // Append property ID
  static const String addFavorite = 'properties/{id}/favorite';
  static const String removeFavorite = 'properties/{id}/unfavorite';
  static const String myFavorites = 'user/profile/favorites';
  static const String approveProvider = 'admin/provider/{id}/status';
  static const String deleteProperty = "admin/properties/{propertyId}";
  static const String deleteMyProperty = "properties/{propertyId}";

  //by admin
  static const String updateMyProperty = 'properties/{id}'; //customer,provider
  static const String createRequest =
      'requests'; //customer create request to add the property

  static const String getMyRequests = 'requests'; //customer get his requests
  static const String getMyProperties = 'properties/my'; //customer,provider
  static const String getCustomerRequests =
      'admin/customer-requests'; //admin get all customer requests

  static const String getProviderRequests =
      'admin/provider-requests'; //admin get all customer requests

  static const String getRequestByIdAdmin = 'admin/requests/{id}';
  static const String getRequestByIdCustomer = 'requests/{id}';
  static const String deleteMyRequest = 'requests/{id}'; //customer
  static const String deleteRequest = 'requests/{id}'; //by admin
  static const String changeRequestStatus =
      'admin/requests/{id}/status'; //by admin

  // profile data

  static const String getProfile = "user/profile";
  static const String updateProfile = "user/profile";
  static const String deleteProfile = "user/profile";
  static const String uploadProfilePicture = "user/profile/pfp";
  static const String deleteProfilePicture = "user/profile/pfp";

  //media data
  static const uploadMedia = "properties/{id}/media-upload";
  static const getAllMedia = "properties/{id}/media";
  static const getSingleMedia = "properties/media/{id}";
  static const deleteMedia = "properties/{pId}/media/{mId}";
}
