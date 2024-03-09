import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/view/home_widgets/request_tile_widget.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    var id = FirebaseAuth.instance.currentUser?.uid.toString();
    // debugger();
    print(id);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.sp),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("requests")
                .doc(id)
                .collection("users")
                .snapshots(),
            builder: (context, snapshot) {
              // debugger();
              if (snapshot.hasData) {
                QuerySnapshot data = snapshot.data!;
                // ignore: unnecessary_null_comparison
                if (data != null && data.docs.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(data.docs.length, (index) {
                        data.docs[index];
                        // debugger();
                        var user = UserModel(
                            isVerified:
                                data.docs[index].get('isVerified') ?? false,
                            acceptRequest:
                                data.docs[index].get('acceptRequest') ?? false,
                            cast: data.docs[index].get('cast') ?? '',
                            PhoneNumber:
                                data.docs[index].get('PhoneNumber') ?? '',
                            about: data.docs[index].get('about') ?? '',
                            city: data.docs[index].get('city') ?? '',
                            color: data.docs[index].get('color') ?? '',
                            country: data.docs[index].get('country') ?? '',
                            dateOfBirth:
                                data.docs[index].get('dateOfBirth') ?? '',
                            firstName: data.docs[index].get('firstName') ?? '',
                            gender: data.docs[index].get('gender') ?? '',
                            height: data.docs[index].get('height') ?? '',
                            howDidYouHearAboutUs:
                                data.docs[index].get('howDidYouHearAboutUs') ??
                                    '',
                            id: data.docs[index].get('id') ?? '',
                            lastName: data.docs[index].get('lastName') ?? '',
                            maritalStatus:
                                data.docs[index].get('maritalStatus') ?? '',
                            profileImage:
                                data.docs[index].get('profileImage') ?? '',
                            religion: data.docs[index].get('religion') ?? '',
                            state: data.docs[index].get('state') ?? '',
                            isLike: data.docs[index].get('isLike') ?? '',
                            isRequestPlaced:
                                data.docs[index].get('isRequestPlaced') ?? '',
                            email: data.docs[index].get('email') ?? '',
                            location: data.docs[index].get('location') ?? '');
                        // debugger();
                        if (!user.acceptRequest) {
                          return RequestTileWidget(
                            model: user,
                          );
                        }
                        return SizedBox();
                      })
                    ],
                  );
                } else
                  return Center(child: Text("No Requests Found!"));
              }
              return Center(child: Text("No Requests Found!"));
            }),
      ),
    );
  }
}
