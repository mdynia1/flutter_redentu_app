import 'package:flutter/cupertino.dart';

class Article {
  String title;
  String author;
  String description;
  String urlToImage;
  DateTime publshedAt;
  String content;
  String articleUrl;

  Article(
      {@required this.title,
      this.description,
      this.author,
      this.content,
      this.publshedAt,
      this.urlToImage,
      this.articleUrl});

  toMap() {}

  fromMap() {}
}
