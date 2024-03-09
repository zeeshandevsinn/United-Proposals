import 'package:flutter/material.dart';
import 'package:united_proposals_app/view/login_screen.dart';

class NotVerifiedScreen extends StatefulWidget {
  const NotVerifiedScreen({super.key});

  @override
  State<NotVerifiedScreen> createState() => _NotVerifiedScreenState();
}

class _NotVerifiedScreenState extends State<NotVerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size * 1;
    return Center(
        child: Container(
            margin: EdgeInsets.all(40.0),
            height: 400,
            width: size.width * .90,
            child: AlertDialog(
              title: Text('Verification Required'),
              content:
                  Text('You are not verified. Please verify your account.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false);
                  },
                  child: Text('Close'),
                ),
              ],
            )));
  }
}
