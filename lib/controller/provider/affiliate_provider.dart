import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:united_proposals_app/models/category_model.dart';
import '../../models/affiliate_program_model.dart';

class AffiliateProvider extends ChangeNotifier {
  bool isAll = true;
  int selectedCategoryIndex = 0;

  CategoryModel? categoryCategoryModel;

  List<CategoryModel> categoryList = [
    CategoryModel(name: 'Marriage Halls'),
    CategoryModel(name: 'Marquee'),
    CategoryModel(name: 'Jewellers'),
    CategoryModel(name: 'Caterers'),
    CategoryModel(name: 'Car Rental Service'),
    CategoryModel(name: 'Decoration'),
    CategoryModel(name: 'Nikah khawan'),
    CategoryModel(name: 'Event Planner'),
    CategoryModel(name: 'Boutique'),
  ];
  int fetchdata = 0;
  Future<void> fetchUserData() async {
    try {
      // Fetch user data from Firebase Firestore

      // ZBotToast.loadingShow();
      if (fetchdata > 0) {
        return;
      } else {
        fetchdata++;
        var data = await FirebaseFirestore.instance
            .collection("admin_users_client")
            .get();
        // debugger();

        for (var i = 0; i < data.docs.length; i++) {
          log(data.docs[i].data().toString());

          userList.add(AffilateProgramModel(
            fullName: data.docs[i].get('fullName'),
            about: data.docs[i].get('about'),
            phoneNumber: data.docs[i].get('PhoneNumber'),
            location: data.docs[i].get('Location'),
            category: data.docs[i].get('Category'),
            email: data.docs[i].get('email'),
            profileImage: data.docs[i].get('profileImage'),
            city: data.docs[i].get('city'),
            country: data.docs[i].get('country'),
            state: data.docs[i].get('state'),
          ) as AffilateProgramModel);
        }
      }

      // ZBotToast.loadingClose();
      // StreamBuilder(
      //     stream: FirebaseFirestore.instance.collection("users").snapshots(),
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

  List<AffilateProgramModel> userList = [];
  List<AffilateProgramModel> affilateList = [
    AffilateProgramModel(
      // id: "1",

      category: "2",
      about: 'Taj Mahal Banquet Hall',
      profileImage:
          'https://racheldaltonweddings.co.uk/wp-content/uploads/sites/6436/2020/07/Pylewell_0176-scaled.jpg',

      location: '9, Abu Bakar Block New Garden Town, Lahore, Punjab 54600',
      phoneNumber: '0323 2323232',
      email: "abs@gmail.com",
    ),
    AffilateProgramModel(
      // id: "2",
      category: "3",
      about: 'Shahjahan Banquet Hall',
      profileImage:
          'https://scontent.flhe3-1.fna.fbcdn.net/v/t39.30808-6/347404799_292375129896638_6728610637442047983_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=5f2048&_nc_ohc=BbnqbygGFvQAX8V1gfi&_nc_ht=scontent.flhe3-1.fna&oh=00_AfAzrsoH63I_8UsZxCCqOsvt9do-xRHvBXNcRjWVvI_Jhw&oe=653462AC',
      // isLike: false,
      location: 'New Garden Town, Lahore, Punjab 54600',
      phoneNumber: '0323 2323232',
      email: "abs@gmail.com",
    ),
    AffilateProgramModel(
      // id: "3",
      category: "4",
      about: 'Mehmaan Khana Hall',
      profileImage:
          'https://blog.shadiyana.pk/wp-content/uploads/2022/11/image-1024x768.png',
      // isLike: false,
      location: 'New Garden Town, Lahore, Punjab 54600',
      phoneNumber: '0323 2323232',
      email: "abs@gmail.com",
    ),
  ];

  void update() {
    notifyListeners();
  }
}
