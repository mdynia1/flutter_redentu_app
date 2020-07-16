import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:redentuapp/models/user.dart';
import 'package:redentuapp/screens/profile_screen.dart';
import 'package:redentuapp/constants.dart';
import 'package:redentuapp/widgets/rounded_button.dart';
import 'package:toast/toast.dart';

import '../services//fireStore_services.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    userName.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Become a member'),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
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
                    height: 200.0,
                    child: Image.asset(
                      'images/news-logo.png',
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Text(
                'Unlimmited ',
                style: kMainTextStyle,
              ),
              Text(
                'Access!',
                style: kMainTextStyle,
              ),
              TextField(
                controller: userName,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  //userName.text = value;
                },
                decoration: InputDecoration(labelText: 'User Login'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: password,
                obscureText: true,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  // password.text = value;
                },
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.black87,
                onPressed: () async {
                  if (userName != null && password != null) {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      String userN = userName.text + '@gmail.com';
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: userN, password: password.text);
                      if (newUser != null) {
                        final userAuth = await _auth.currentUser();
                        User user = User(
                            id: userAuth.uid,
                            fullName: '',
                            email: '',
                            phone: '',
                            userName: userName.text);
                        FirestoreService().createUser(user);
                        Navigator.pushNamed(context, ProfileScreen.id);
                      } else {
                        Toast.show('Username already exists', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      Toast.show(e.toString(), context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  }
                },
              ),
              RoundedButton(
                  title: 'Have an account',
                  colour: Colors.black54,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
