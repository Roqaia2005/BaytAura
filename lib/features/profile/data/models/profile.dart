class Profile {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String? profilePictureUrl;
  final String role;
  final String? companyName;
  final String? companyAddress;

  Profile({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.profilePictureUrl,
    this.companyName,
    this.companyAddress,
    required this.role,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      profilePictureUrl: json['profilePictureUrl'],
      role: json['role'],
      companyName: json['companyName'],
      companyAddress: json['companyAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "profilePictureUrl": profilePictureUrl,
      "role": role,
      "companyName": companyName,
      "companyAddress": companyAddress,
    };
  }
}
