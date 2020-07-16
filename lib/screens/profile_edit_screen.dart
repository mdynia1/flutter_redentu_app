import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redentuapp/models/user.dart';
import 'package:redentuapp/screens/camera_screen.dart';
import 'package:redentuapp/widgets/rounded_button.dart';
import 'package:redentuapp/services/fireStore_services.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ProfileEditScreen extends StatefulWidget {
  static const String id = 'ProfileEditScreen';
  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  String userName = '';

  bool loaded = false;
  User userData;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        loaded = true;
        print(loggedInUser.email);
        userName = loggedInUser.email.replaceAll('@gmail.com', '');

        userData = await FirestoreService().getUser(user.uid);
        fullNameController.text = userData.fullName;
        emailController.text = userData.email;
        phoneController.text = userData.phone;

        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loaded == true) {
      return Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                }),
          ],
          title: Text('Edit profile'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 250.0,
                      child: Image.asset(
                        'images/news-logo.png',
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: fullNameController,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    //  userId = value;
                  },
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    // userId = value;
                  },
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: phoneController,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    //userId = value;
                  },
                  decoration: InputDecoration(labelText: 'Phone number'),
                ),
                SizedBox(
                  height: 15,
                ),
                RoundedButton(
                  title: 'Save',
                  colour: Colors.black54,
                  onPressed: () {
                    User user = User(
                        id: loggedInUser.uid,
                        fullName: fullNameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        userName:
                            loggedInUser.email.replaceAll('@gmail.com', ''));
                    FirestoreService().createUser(user);
                    Navigator.pop(context);
                  },
                ),
              ]),
        ),
      );
    } else {
      return SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      );
    }
  }
}
