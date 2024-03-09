import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/';
import 'package:flutter/material.dart';
import 'package:united_proposals_app/constants/enums.dart';
import 'package:united_proposals_app/models/how_to_here_model.dart';
import 'package:united_proposals_app/models/selection_model.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';

class RootProvider extends ChangeNotifier {
  // List<UserModel> userList1 = [];
  PageController pageController = PageController(initialPage: 2);

  bool isLoading = false;
  int selectedScreenValue = 2;
  int fetchDataTime = 0;
  bool userVerfied = false;
  loginUserData(id) async {
    var data =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    if (data.get('isVerified') == true) {
      userVerfied = true;
    } else {
      ZBotToast.showToastError(message: "Your Profile is Not Verified");
    }
  }

  AdminFilterUsers() async {
    if (fetchDataTime > 0) {
      // notifyListeners();
      return;
    } else {
      try {
        fetchDataTime++;
        // Fetch user data from Firebase Firestore

        // ZBotToast.loadingShow();

        var data = await FirebaseFirestore.instance.collection("users").get();
        // debugger();

        for (var i = 0; i < data.docs.length; i++) {
          if (data.docs[i].get('isVerified') == false) {
            // debugger();
            log(data.docs[i].data().toString());

            userList.add(UserModel(
                acceptRequest: data.docs[i].get('acceptRequest'),
                isVerified: data.docs[i].get('isVerified'),
                PhoneNumber: data.docs[i].get('PhoneNumber') ?? '',
                email: data.docs[i].get('email') ?? '',
                about: data.docs[i].get('about') ?? '',
                city: data.docs[i].get('city') ?? '',
                cast: data.docs[i].get('cast') ?? '',
                color: data.docs[i].get('color') ?? '',
                country: data.docs[i].get('country') ?? '',
                dateOfBirth: data.docs[i].get('dateOfBirth') ?? '',
                firstName: data.docs[i].get('firstName') ?? '',
                gender: data.docs[i].get('gender') ?? '',
                height: data.docs[i].get('height') ?? '',
                howDidYouHearAboutUs:
                    data.docs[i].get('howDidYouHearAboutUs') ?? '',
                id: data.docs[i].get('id') ?? '',
                lastName: data.docs[i].get('lastName') ?? '',
                maritalStatus: data.docs[i].get('maritalStatus') ?? '',
                profileImage: data.docs[i].get('profileImage') ?? '',
                religion: data.docs[i].get('religion') ?? '',
                state: data.docs[i].get('state') ?? '',
                isLike: data.docs[i].get('isLike') ?? '',
                isRequestPlaced: data.docs[i].get('isRequestPlaced') ?? '',
                location: data.docs[i].get('location')));
          }
        }

        notifyListeners();
        // Map the documents to a list of UserModel
      } catch (error) {
        print('Error fetching user data: $error');
      }
    }
  }

  filterAdminVerifiedPerson() async {
    // debugger();
    return userList.where((user) {
      // debugger();
      return userList.any((isVerified) => user.isVerified == false);
    }).toList();
  }

  fetchFriendRequests(String currentUserUid) async {
    // Use Firestore query to get friend requests for the current user
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('requests')
        .doc(
            currentUserUid) // Assuming the document ID is the current user's ID
        .collection('users')
        .get();

    // Convert the data from Firestore into a list of FriendRequest objects
    return snapshot.docs
        .map((doc) => UserModel(
            isVerified: doc['isVerified'],
            acceptRequest: doc['acceptRequest'],
            PhoneNumber: doc['PhoneNumber'] ?? '',
            email: doc['email'] ?? '',
            about: doc['about'] ?? '',
            city: doc['city'] ?? '',
            cast: doc['cast'] ?? '',
            color: doc['color'] ?? '',
            country: doc['country'] ?? '',
            dateOfBirth: doc['dateOfBirth'] ?? '',
            firstName: doc['firstName'] ?? '',
            gender: doc['gender'] ?? '',
            height: doc['height'] ?? '',
            howDidYouHearAboutUs: doc['howDidYouHearAboutUs'] ?? '',
            id: doc['id'] ?? '',
            lastName: doc['lastName'] ?? '',
            maritalStatus: doc['maritalStatus'] ?? '',
            profileImage: doc['profileImage'] ?? '',
            religion: doc['religion'] ?? '',
            state: doc['state'] ?? '',
            isLike: doc['isLike'] ?? '',
            isRequestPlaced: doc['isRequestPlaced'] ?? '',
            location: doc['location']))
        .toList();
  }

  List<UserModel> filterUsers(
      List<UserModel> allUsers, List<UserModel> friendRequests) {
    // debugger();
    return allUsers.where((user) {
      // debugger();
      return !friendRequests
          .any((request) => user.id == request.id && request.acceptRequest);
    }).toList();
  }

  fetchUserData(id) async {
    if (fetchDataTime > 0) {
      // notifyListeners();
      return;
    } else {
      try {
        fetchDataTime++;
        // Fetch user data from Firebase Firestore

        // ZBotToast.loadingShow();

        var data = await FirebaseFirestore.instance.collection("users").get();
        // debugger();

        for (var i = 0; i < data.docs.length; i++) {
          if (data.docs[i].get('id') != id) {
            // debugger();
            log(data.docs[i].data().toString());

            userList.add(UserModel(
                acceptRequest: data.docs[i].get('acceptRequest'),
                isVerified: data.docs[i].get('isVerified'),
                PhoneNumber: data.docs[i].get('PhoneNumber') ?? '',
                email: data.docs[i].get('email') ?? '',
                about: data.docs[i].get('about') ?? '',
                city: data.docs[i].get('city') ?? '',
                cast: data.docs[i].get('cast') ?? '',
                color: data.docs[i].get('color') ?? '',
                country: data.docs[i].get('country') ?? '',
                dateOfBirth: data.docs[i].get('dateOfBirth') ?? '',
                firstName: data.docs[i].get('firstName') ?? '',
                gender: data.docs[i].get('gender') ?? '',
                height: data.docs[i].get('height') ?? '',
                howDidYouHearAboutUs:
                    data.docs[i].get('howDidYouHearAboutUs') ?? '',
                id: data.docs[i].get('id') ?? '',
                lastName: data.docs[i].get('lastName') ?? '',
                maritalStatus: data.docs[i].get('maritalStatus') ?? '',
                profileImage: data.docs[i].get('profileImage') ?? '',
                religion: data.docs[i].get('religion') ?? '',
                state: data.docs[i].get('state') ?? '',
                isLike: data.docs[i].get('isLike') ?? '',
                isRequestPlaced: data.docs[i].get('isRequestPlaced') ?? '',
                location: data.docs[i].get('location')));
          }
        }

        // ZBotToast.loadingClose();
        // StreamBuilder(
        //     stream: FirebaseFirestore.instance.collection("users").snapshots()??'',
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (snapshot.hasData) {
        //         QuerySnapshot data = snapshot.data;
        //         for (var i = 0; i < data.docs.length; i++) {
        //           userList.add(UserModel(
        //               PhoneNumber: data.docs[i].get('PhoneNumber'),
        //               email: data.docs[i].get('email'),
        //               about: data.docs[i].get('about'),
        //               city: data.docs[i].get('city'),
        //               color: data.docs[i].get('color'),
        //               country: data.docs[i].get('country'),
        //               dateOfBirth: data.docs[i].get('dateOfBirth'),
        //               firstName: data.docs[i].get('firstName'),
        //               gender: data.docs[i].get('gender'),
        //               height: data.docs[i].get('height'),
        //               howDidYouHearAboutUs:
        //                   data.docs[i].get('howDidYouHearAboutUs'),
        //               id: data.docs[i].get('id'),
        //               lastName: data.docs[i].get('lastName'),
        //               maritalStatus: data.docs[i].get('martialStatus'),
        //               profileImage: data.docs[i].get('profileImage'),
        //               religion: data.docs[i].get('religion'),
        //               state: data.docs[i].get('state'),
        //               isLike: data.docs[i].get('isLike'),
        //               isRequestPlaced: data.docs[i].get('isRequestPlaced'),
        //               location: data.docs[i].get('location')));
        //         }
        //       }
        //       return ZBotToast.loadingShow();
        //     });

        notifyListeners();
        // Map the documents to a list of UserModel
      } catch (error) {
        print('Error fetching user data: $error');
      }
    }
  }

  List<UserModel> userList = [];
  List<UserModel> friendRequests = [];
  FilterUserbyRequest() async {
    // debugger();

    friendRequests =
        await fetchFriendRequests(FirebaseAuth.instance.currentUser!.uid);

    filteredUsers = await filterUsers(userList, friendRequests);
    notifyListeners();
  }

  List<UserModel> filteredUsers = [];

  // List<UserModel> userList = [
  //   UserModel(
  //     id: '1',
  //     username: 'user1',
  //     firstName: 'John',
  //     lastName: 'Doe',
  //     gender: 'Male',
  //     age: 28,
  //     maritalStatus: MaritalStatus.unmarried,
  //     location: 'New York',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  //     description: 'I am a fun-loving person!',
  //     isLike: false,
  //   ),
  //   UserModel(
  //     id: '2',
  //     username: 'user2',
  //     firstName: 'Jane',
  //     lastName: 'Smith',
  //     gender: 'Female',
  //     age: 25,
  //     maritalStatus: MaritalStatus.married,
  //     location: 'Los Angeles',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  //     description: 'Looking for a serious relationship.',
  //     isLike: true,
  //   ),
  //   UserModel(
  //     id: '3',
  //     username: 'user3',
  //     firstName: 'Mike',
  //     lastName: 'Johnson',
  //     gender: 'Male',
  //     age: 30,
  //     maritalStatus: MaritalStatus.unmarried,
  //     location: 'Chicago',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  //     description: 'I enjoy traveling and outdoor activities.',
  //     isLike: true,
  //   ),
  //   UserModel(
  //     id: '4',
  //     username: 'user4',
  //     firstName: 'Emily',
  //     lastName: 'Williams',
  //     gender: 'Female',
  //     age: 27,
  //     maritalStatus: MaritalStatus.divorced,
  //     location: 'San Francisco',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  //     description: 'I have a passion for art and music.',
  //     isLike: false,
  //   ),
  //   UserModel(
  //     id: '5',
  //     username: 'user5',
  //     firstName: 'David',
  //     lastName: 'Brown',
  //     gender: 'Male',
  //     age: 32,
  //     maritalStatus: MaritalStatus.married,
  //     location: 'Miami',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/1081685/pexels-photo-1081685.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  //     description: 'Seeking a partner who loves cooking.',
  //     isLike: false,
  //   ),
  //   UserModel(
  //     id: '1',
  //     username: 'user1',
  //     firstName: 'John',
  //     lastName: 'Doe',
  //     gender: 'Male',
  //     age: 28,
  //     maritalStatus: MaritalStatus.unmarried,
  //     location: 'New York',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  //     description: 'I am a fun-loving person!',
  //     isLike: false,
  //   ),
  //   UserModel(
  //     id: '2',
  //     username: 'user2',
  //     firstName: 'Jane',
  //     lastName: 'Smith',
  //     gender: 'Female',
  //     age: 25,
  //     maritalStatus: MaritalStatus.married,
  //     location: 'Los Angeles',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  //     description: 'Looking for a serious relationship.',
  //     isLike: true,
  //   ),
  //   UserModel(
  //     id: '3',
  //     username: 'user3',
  //     firstName: 'Mike',
  //     lastName: 'Johnson',
  //     gender: 'Male',
  //     age: 30,
  //     maritalStatus: MaritalStatus.unmarried,
  //     location: 'Chicago',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  //     description: 'I enjoy traveling and outdoor activities.',
  //     isLike: true,
  //   ),
  //   UserModel(
  //     id: '4',
  //     username: 'user4',
  //     firstName: 'Emily',
  //     lastName: 'Williams',
  //     gender: 'Female',
  //     age: 27,
  //     maritalStatus: MaritalStatus.divorced,
  //     location: 'San Francisco',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  //     description: 'I have a passion for art and music.',
  //     isLike: false,
  //   ),
  //   UserModel(
  //     id: '5',
  //     username: 'user5',
  //     firstName: 'David',
  //     lastName: 'Brown',
  //     gender: 'Male',
  //     age: 32,
  //     maritalStatus: MaritalStatus.married,
  //     location: 'Miami',
  //     profileImageUrl:
  //         'https://images.pexels.com/photos/1081685/pexels-photo-1081685.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  //     description: 'Seeking a partner who loves cooking.',
  //     isLike: false,
  //   ),
  // ];
  List<UserModel> requestList = [
    // UserModel(
    //   id: '1',
    //   firstName: 'Jhon Doe',
    //   lastName: 'Doe',
    //   gender: 'Male',
    //   // maritalStatus: MaritalStatus.unmarried,
    //   location: 'New York',
    //   // profileImageUrl:
    //   //     'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //   // description: 'I am a fun-loving person!',
    //   isRequestPlaced: true,
    //   about: '',
    //   city: '',
    //   color: '',
    //   country: '',
    //   dateOfBirth: '',
    //   height: 100,
    //   howDidYouHearAboutUs: '',
    //   maritalStatus: '',
    //   profileImage: '',
    //   religion: '',
    //   state: '',
    //   PhoneNumber: '',
    //   email: '',
    //   isLike: false,

    //   // isRequestAccepted: false,
    // ),
    // UserModel(
    //   id: '2',
    //   firstName: 'Jane',
    //   lastName: 'Smith',
    //   gender: 'Female',
    //   // age: 25,
    //   // maritalStatus: MaritalStatus.married,
    //   location: 'Los Angeles',
    //   // profileImageUrl:
    //   //     'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //   // description: 'Looking for a serious relationship.',
    //   isRequestPlaced: true,
    //   // isRequestAccepted: false,
    // ),
    // UserModel(
    //   id: '3',
    //   username: 'user3',
    //   firstName: 'Mike',
    //   lastName: 'Johnson',
    //   gender: 'Male',
    //   age: 30,
    //   maritalStatus: MaritalStatus.unmarried,
    //   location: 'Chicago',
    //   profileImageUrl:
    //       'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //   description: 'I enjoy traveling and outdoor activities.',
    //   isLike: true,
    //   isRequestPlaced: true,
    //   isRequestAccepted: false,
    // ),
  ];

  // Religion List

  List<ReligionEnum> religionList = [
    ReligionEnum.muslim,
    ReligionEnum.chritian
  ];
  List<SelectionModel> sectList = [
    SelectionModel(id: "3232ada32", name: "Syed"),
    SelectionModel(id: "3232a32", name: "Suni"),
    SelectionModel(id: "32323d2", name: "Shia"),
    SelectionModel(id: "32323e2", name: "Whabbi"),
    SelectionModel(id: "32323f2", name: "Salafi"),
    SelectionModel(id: "323232s", name: "Berelvi"),
    SelectionModel(id: "323232sg", name: "Sufi"),
    SelectionModel(id: "3232332", name: "Deobandi"),
  ];

  List<SelectionModel> castList = [
    SelectionModel(id: "1", name: "Syed"),
    SelectionModel(id: "2", name: "Rajput"),
    SelectionModel(id: "3", name: "Arain"),
    SelectionModel(id: "4", name: "Lohaar"),
    SelectionModel(id: "5", name: "Chamar"),
    SelectionModel(id: "6", name: "Gaadi"),
    SelectionModel(id: "7", name: "Gujjar"),
    SelectionModel(id: "8", name: "Awan"),
    SelectionModel(id: "9", name: "Darkhan"),
    SelectionModel(id: "10", name: "Kumhar"),
    SelectionModel(id: "11", name: "Jutt"),
    SelectionModel(id: "12", name: "Khatri"),
    SelectionModel(id: "13", name: "Mirasi"),
    SelectionModel(id: "14", name: "Kamboh"),
    SelectionModel(id: "15", name: "Others"),
  ];
  List<SelectionModel> cristianSectList = [
    SelectionModel(id: "1", name: "Catholic"),
    SelectionModel(id: "10", name: "Protestant"),
    SelectionModel(id: "2", name: "Orthodox"),
    SelectionModel(id: "3", name: "Catholicism"),
    SelectionModel(id: "4", name: "Protestantism"),
    SelectionModel(id: "5", name: "Eastern"),
    SelectionModel(id: "6", name: "Oriental"),
    SelectionModel(id: "7", name: "Jehovah's Witnesses"),
    SelectionModel(id: "8", name: "Christian Science"),
    SelectionModel(id: "9", name: "Quakers"),
  ];

  List<GenderModel> genderList = [
    GenderModel(id: "1", name: "Male"),
    GenderModel(id: "2", name: "Female"),
    GenderModel(id: "3", name: "Other"),
    GenderModel(id: "4", name: "prefer not to say"),
  ];

  List<HowToHereModel> howToHereList = [
    HowToHereModel(id: "1", name: "Friends"),
    HowToHereModel(id: "2", name: "Online Ads"),
    HowToHereModel(id: "3", name: "Social Media"),
    HowToHereModel(id: "4", name: "Others"),
  ];

  void update() {
    notifyListeners();
  }
}
