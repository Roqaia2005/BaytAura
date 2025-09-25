class ProviderRequest {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? profilePictureUrl;
  String? role;
  String? companyName;
  String? companyAddress;
  String? status;

  ProviderRequest({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.profilePictureUrl,
    this.role,
    this.companyName,
    this.companyAddress,
    this.status,
  });

  ProviderRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    profilePictureUrl = json['profilePictureUrl'];
    role = json['role'];
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['profilePictureUrl'] = profilePictureUrl;
    data['role'] = role;
    data['companyName'] = companyName;
    data['companyAddress'] = companyAddress;
    data['status'] = status;
    return data;
  }
}
