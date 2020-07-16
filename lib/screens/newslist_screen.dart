import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redentuapp/services/json_news_decoder.dart';
import 'package:redentuapp/models/article.dart';
import 'package:redentuapp/screens/camera_screen.dart';
import 'package:redentuapp/screens/login_screen.dart';
import 'package:redentuapp/screens/qr_screen.dart';
import 'package:redentuapp/screens/registration_screen.dart';
import 'package:redentuapp/widgets/news_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';
import 'profile_screen.dart';
import 'package:redentuapp/constants.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsListScreen extends StatefulWidget {
  static const String id = 'NewsListScreen';
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  List<Article> newslist = [];
  bool _loaded = false;
  bool _loggedIn = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    return user != null;
  }

  void getNews() async {
    try {
      NewsDecoder news = NewsDecoder();
      newslist = await news.getNews();
      _loggedIn = await isUserLoggedIn();
      setState(() {
        _loaded = true;
      });
    } catch (e) {
      Toast.show(e, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      _loaded = true;
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    if (_loaded == true) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Discover news',
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
              // Use the MdiIcons class for the IconData
              icon: new Icon(MdiIcons.qrcode),
              onPressed: () {
                Navigator.pushNamed(context, QrScreen.id).then((value) {
                  getNews();
                  setState() {}
                });
              }),
          actions: <Widget>[
            IconButton(

                // Use the MdiIcons class for the IconData
                icon: new Icon(MdiIcons.camera),
                onPressed: () {
                  Navigator.pushNamed(context, CameraScreen.id)
                      .then((value) {});
                }),
            IconButton(

                // Use the MdiIcons class for the IconData
                icon: new Icon(MdiIcons.account),
                onPressed: () {
                  if (!_loggedIn) {
                    Navigator.pushNamed(context, LoginScreen.id).then((value) {
                      getNews();
                      setState() {}
                    });
                  } else
                    Navigator.pushNamed(context, ProfileScreen.id)
                        .then((value) {
                      getNews();
                      setState() {}
                    });
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Container(
              margin: EdgeInsets.all(12),
              child: ListView.builder(
                  itemCount: newslist.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsBox(
                        newslist[index].title,
                        newslist[index].description,
                        newslist[index].urlToImage,
                        newslist[index].articleUrl);
                  }),
            ),
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
