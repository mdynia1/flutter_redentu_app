import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:redentuapp/screens/profile_screen.dart';
import 'package:redentuapp/screens/registration_screen.dart';
import 'package:redentuapp/widgets/rounded_button.dart';
import 'package:redentuapp/constants.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  String userId;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in Page'),
      ),
      resizeToAvoidBottomInset: true,
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
                    height: 100.0,
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
                'Welcome ',
                style: kMainTextStyle,
              ),
              Text(
                'Back!',
                style: kMainTextStyle,
              ),
              TextField(
                controller: loginController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  userId = value;
                },
                decoration: InputDecoration(labelText: 'User Login'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.black87,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    userId = userId + '@gmail.com';
                    final user = await _auth.signInWithEmailAndPassword(
                        email: userId, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ProfileScreen.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                    Toast.show(
                        'There is no user record corresponding to this identifie',
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM);
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              ),
              RoundedButton(
                title: 'Sign up',
                colour: Colors.black54,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
