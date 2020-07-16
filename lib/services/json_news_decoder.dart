import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:redentuapp/models/article.dart';

class NewsDecoder {
  final String url =
      'https://newsapi.org/v2/top-headlines?country=ua&pageSize=100&apiKey=';
  final String _key = 'f0a3bb4c4a984f31999bbd0cdd0fe73e';

  Future<List<Article>> getNews() async {
    http.Response response = await http.get(url + _key);
    final List<Article> newsList = [];
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      decodedData["articles"].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          newsList.add(Article(
            title: article['title'],
            author: article['author'],
            description: article['description'],
            urlToImage: article['urlToImage'],
            publshedAt: DateTime.parse(article['publishedAt']),
            content: article["content"],
            articleUrl: article["url"],
          ));
        }
      });
    }
    return (newsList);
  }
}
