class AdminModel {
  String? category;
  String? location;
  String? phoneNumber;
  String? about;
  String? city;
  String? country;
  String? email;
  String? fullName;
  String? profileImage;
  String? state;

  AdminModel(
      {this.category,
      this.location,
      this.phoneNumber,
      this.about,
      this.city,
      this.country,
      this.email,
      this.fullName,
      this.profileImage,
      this.state});

  AdminModel.fromJson(Map<String, dynamic> json) {
    category = json['Category'];
    location = json['Location'];
    phoneNumber = json['PhoneNumber'];
    about = json['about'];
    city = json['city'];
    country = json['country'];
    email = json['email'];
    fullName = json['fullName'];
    profileImage = json['profileImage'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Category'] = this.category;
    data['Location'] = this.location;
    data['PhoneNumber'] = this.phoneNumber;
    data['about'] = this.about;
    data['city'] = this.city;
    data['country'] = this.country;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['profileImage'] = this.profileImage;
    data['state'] = this.state;
    return data;
  }
}
