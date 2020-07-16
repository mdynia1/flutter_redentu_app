import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redentuapp/models/user.dart';
import 'package:redentuapp/screens/newslist_screen.dart';
import 'package:redentuapp/screens/profile_edit_screen.dart';
import 'package:redentuapp/screens/camera_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redentuapp/widgets/rounded_button.dart';
import 'package:toast/toast.dart';

import '../services/fireStore_services.dart';
import 'package:redentuapp/widgets/profile_tilecard.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ProfileScreen extends StatefulWidget {
  static const id = 'ProfileScreen';

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String phoneNumber = '';
  String nameFirst, nameLast = '';
  String userName = '';
  bool loaded = false;
  User userData;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        loaded = true;
        userName = loggedInUser.email.replaceAll('@gmail.com', '');

        userData = await FirestoreService().getUser(user.uid);
        print(userData.fullName);

        setState(() {});
      }
    } catch (e) {
      print(e);
      Toast.show(e, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        loaded = true;
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loaded == true) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.pushNamed(context, NewsListScreen.id);
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                }),
          ],
          title: Text('Welcome, $userName'),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 150.0,
                        child: Image.asset(
                          'images/news-logo.png',
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    userData.userName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'FLUTTER NEWS MEMBER',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                  ProfileTileCard(
                      iconData: MdiIcons.account,
                      text: userData.phone == null ? '' : userData.fullName),
                  ProfileTileCard(
                      iconData: Icons.email,
                      text: userData.email == null ? '' : userData.email),
                  ProfileTileCard(
                      iconData: Icons.phone,
                      text: userData.phone == null ? '' : userData.phone),
                  RoundedButton(
                    title: 'Edit',
                    colour: Colors.black54,
                    onPressed: () {
                      Navigator.pushNamed(context, ProfileEditScreen.id)
                          .then((value) {
                        loaded = false;
                        getCurrentUser();
                        setState(() {});
                      });
                    },
                  ),
                  RoundedButton(
                    title: 'Log out',
                    colour: Colors.black87,
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pop(context);
                    },
                  ),
                ]),
          ),
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
