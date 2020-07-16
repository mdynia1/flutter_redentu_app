import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  static const String id = 'ArticleScreen';
  String articleUrl = '';
  ArticleScreen(this.articleUrl);

  @override
  ArticleScreenState createState() => ArticleScreenState();
}

class ArticleScreenState extends State<ArticleScreen> {
  bool _loading = true;

  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter News",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: IndexedStack(
        index: _stackToView,
        children: [
          Column(
            children: <Widget>[
              Expanded(
                  child: WebView(
                // key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.articleUrl,
                onPageFinished: _handleLoad,
              )),
            ],
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
//      Stack(
//        children: <Widget>[
//          _loading
//              ? Container(
//                  alignment: FractionalOffset.center,
//                  child: CircularProgressIndicator(),
//                )
//              : Container(
//                  color: Colors.transparent,
//                ),
//          Container(
//            height: MediaQuery.of(context).size.height,
//            width: MediaQuery.of(context).size.width,
//            child: WebView(
//              initialUrl:
//                  'https://www.cbsnews.com/news/naya-rivera-body-recovered-lake-piru-watch-california/',
//              onWebViewCreated: (WebViewController webViewController) {
//                _controller.complete(webViewController);
//              },
//              onPageFinished: (finish) {
//                setState(() {
//                  _loading = false;
//                });
//              },
//            ),
//          ),
//        ],
//      ),
    );
  }
}
