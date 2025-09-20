class ApiConstants {
  static const String baseUrl = "http://192.168.1.7:8080/api/";
  static const String login = 'auth/login';
  static const String registerCustomer = 'auth/register/customer';
  static const String registerAdmin = 'auth/register/admin';
  static const String registerProvider = 'auth/register/provider';
  static const String addProperty = 'properties';

  static const String searchProperties = 'properties/search';
  static const String filterProperties = 'properties/filter';

  static const String fetchProperties = 'properties';

  static const String fetchPropertyById = 'properties/'; // Append property ID
  static const String addFavorite = 'properties/{id}/favorite';
  static const String removeFavorite = 'properties/{id}/unfavorite';
  static const String approveProvider = 'admin/provider/{id}/approve';
  static const String deleteProperty = 'admin/properties/{id}'; //by admin
  static const String createRequest =
      'requests'; //customer create request to add the property

  static const String getMyRequests = 'requests'; //customer get his requests
  static const String getAllRequests =
      'admin/requests'; //admin get all requests
  static const String getRequestByIdAdmin = 'admin/requests/{id}';
  static const String getRequestByIdCustomer = 'requests/{id}';
  static const String deleteMyRequest = 'requests/{id}'; //customer
  static const String deleteRequest = 'requests/{id}'; //by admin
  static const String changeRequestStatus =
      'admin/requests/{id}/status'; //by admin



// profile data

static const String getProfile="user/profile";
static const String updateProfile="user/profile";
static const String deleteProfile="user/profile";
static const String uploadProfilePicture="user/profile/pfp";
static const String deleteProfilePicture="user/profile/pfp";
}
