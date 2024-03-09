import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String about;
  String city;
  String color;
  String country;
  String dateOfBirth;
  String firstName;
  String gender;
  double height;
  String howDidYouHearAboutUs;
  String id;
  String lastName;
  String maritalStatus;
  String profileImage;
  String religion;
  String state;
  String location;
  String PhoneNumber;
  String cast;
  bool isLike;
  bool isRequestPlaced;
  bool acceptRequest;
  bool isVerified;
  String email;

  UserModel(
      {required this.about,
      required this.city,
      required this.color,
      required this.country,
      required this.dateOfBirth,
      required this.firstName,
      required this.isVerified,
      required this.gender,
      required this.height,
      required this.howDidYouHearAboutUs,
      required this.id,
      required this.lastName,
      required this.maritalStatus,
      required this.profileImage,
      required this.religion,
      required this.state,
      required this.location,
      required this.PhoneNumber,
      required this.cast,
      required this.email,
      required this.isLike,
      required this.isRequestPlaced,
      required this.acceptRequest});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    data['city'] = this.city;
    data['color'] = this.color;
    data['country'] = this.country;
    data['dateOfBirth'] = this.dateOfBirth;
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['height'] = this.height;
    data['cast'] = this.cast;
    data['isVerified'] = this.isVerified;
    data['howDidYouHearAboutUs'] = this.howDidYouHearAboutUs;
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['maritalStatus'] = this.maritalStatus;
    data['profileImage'] = this.profileImage;
    data['religion'] = this.religion;
    data['state'] = this.state;
    data['location'] = this.location;
    data['PhoneNumber'] = this.PhoneNumber;
    data['email'] = this.email;
    data['isLike'] = this.isLike;
    data['isRequestPlaced'] = this.isRequestPlaced;
    data['acceptRequest'] = this.acceptRequest;
    return data;
  }

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      isVerified: data['isVerified'] ?? false,
      about: data['about'] ?? '',
      city: data['city'] ?? '',
      color: data['color'] ?? '',
      country: data['country'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      firstName: data['firstName'] ?? '',
      gender: data['gender'] ?? '',
      height: data['height'] is double ? data['height'] : 0.0,
      howDidYouHearAboutUs: data['howDidYouHearAboutUs'] ?? '',
      id: data['id'] ?? '',
      lastName: data['lastName'] ?? '',
      maritalStatus: data['maritalStatus'] ?? '',
      profileImage: data['profileImage'] ?? '',
      religion: data['religion'] ?? '',
      state: data['state'] ?? '',
      location: data['location'] ?? '',
      PhoneNumber: data['PhoneNumber'] ?? '',
      cast: data['cast'] ?? '',
      email: data['email'] ?? '',
      isLike: data['isLike'] is bool ? data['isLike'] : false,
      isRequestPlaced:
          data['isRequestPlaced'] is bool ? data['isRequestPlaced'] : false,
      acceptRequest:
          data['acceptRequest'] is bool ? data['acceptRequest'] : false,
    );
  }
  // Setter methods

  void setAbout(String newAbout) {
    about = newAbout;
  }

  void setCity(String newCity) {
    city = newCity;
  }

  void setCast(String newCast) {
    cast = newCast;
  }

  void setColor(String newColor) {
    color = newColor;
  }

  void setCountry(String newCountry) {
    country = newCountry;
  }

  void setDateOfBirth(String newDateOfBirth) {
    dateOfBirth = newDateOfBirth;
  }

  void setFirstName(String newFirstName) {
    firstName = newFirstName;
  }

  void setGender(String newGender) {
    gender = newGender;
  }

  void setHeight(double newHeight) {
    height = newHeight;
  }

  void setHowDidYouHearAboutUs(String newHowDidYouHearAboutUs) {
    howDidYouHearAboutUs = newHowDidYouHearAboutUs;
  }

  void setId(String newId) {
    id = newId;
  }

  void setLastName(String newLastName) {
    lastName = newLastName;
  }

  void setMaritalStatus(String newMaritalStatus) {
    maritalStatus = newMaritalStatus;
  }

  void setProfileImage(String newProfileImage) {
    profileImage = newProfileImage;
  }

  void setReligion(String newReligion) {
    religion = newReligion;
  }

  void setState(String newState) {
    state = newState;
  }

  void setLocation(String newLocation) {
    location = newLocation;
  }

  void setPhoneNumber(String phoneNumber) {
    PhoneNumber = phoneNumber;
  }

  void setIsLike(bool newIsLike) {
    isLike = newIsLike;
  }

  void setIsRequestPlaced(bool newIsRequestPlaced) {
    isRequestPlaced = newIsRequestPlaced;
  }

  void setIsRequestAccept(bool newIsRequestAccept) {
    acceptRequest = newIsRequestAccept;
  }

  void setEmail(String newEmail) {
    email = newEmail;
  }

  void setIsVerified(bool isVerify) {
    isVerified = isVerify;
  }
}



// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:united_proposals_app/constants/enums.dart';

// class UserModel {
//   String? id;
//   String? username;
//   String? firstName;
//   String? lastName;
//   String? gender;
//   int? age;
//   MaritalStatus? maritalStatus;
//   String? location;
//   String? profileImageUrl;
//   String? description;
//   bool? isLike;
//   bool? isRequestPlaced;
//   bool? isRequestAccepted;

//   UserModel({
//     this.id,
//     this.username,
//     this.firstName,
//     this.lastName,
//     this.gender,
//     this.age,
//     this.location,
//     this.profileImageUrl,
//     this.description,
//     this.isLike,
//     this.maritalStatus,
//     this.isRequestPlaced,
//     this.isRequestAccepted,
//   });
//   // need put DocumentSnapShot in it
//   factory UserModel.fromFirestore(doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return UserModel(
//       firstName: data['firstName'] ?? '',
//       lastName: data['lastName'] ?? '',
//       id: data['id'] ?? '',
//       username: data['username'] ?? '',
//       gender: data['gender'] ?? '',
//       age: data['age'] != null ? int.tryParse(data['age']) : null,
//       location: data['location'] ?? '',
//       profileImageUrl: data['profileImageUrl'] ?? '',
//       description: data['description'] ?? '',
//       isLike: data['isLike'] is bool ? data['isLike'] : null,
//       maritalStatus: data['martialStatus'] == 'married'
//           ? MaritalStatus.married
//           : MaritalStatus.unmarried,
//       isRequestPlaced:
//           data['isrequestPlaced'] is bool ? data['isrequestPlaced'] : null,
//       isRequestAccepted:
//           data['isRequestAcceted'] is bool ? data['isRequestAcceted'] : null,
//       // Add other properties...
//     );
//   }
//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['id'] ?? '',
//       username: map['username'] ?? '',
//       firstName: map['firstName'] ?? '',
//       lastName: map['lastName'] ?? '',
//       gender: map['gender'] ?? '',
//       age: map['age'] ?? 0,
//       location: map['location'] ?? '',
//       profileImageUrl: map['profileImageUrl'] ?? '',
//       description: map['description'] ?? '',
//       isLike: map['isLike'] ?? false,
//       maritalStatus: map['martialStatus'] ?? MaritalStatus.unmarried,
//       isRequestPlaced: map['isrequestPlaced'] ?? false,
//       isRequestAccepted: map['isRequestAcceted'] ?? false,
//       // Add other properties...
//     );
//   }
//   toList() {}
// }
