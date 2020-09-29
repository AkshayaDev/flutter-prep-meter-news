import 'package:http/http.dart' as http;
import 'package:prep_meter_news/models/article.dart';
import 'dart:convert';

import 'package:prep_meter_news/secret.dart';
import 'dart:developer' as developer;

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    //String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=${apiKey}";
    String url = "https://www.teammaestros.com/wp-json/flutter/v1";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    developer.log('log me', name: jsonEncode(jsonData));

    jsonData.forEach((element) {
      if (element['urlToImage'] != null && element['description'] != null) {
        Article article = Article(
          title: element['title'],
          author: element['author'],
          description: element['description'],
          urlToImage: element['urlToImage'],
          publshedAt: DateTime.parse(element['publishedAt']),
          content: element["content"],
          articleUrl: element["url"],
        );
        news.add(article);
      }
    });

    /*if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }*/
  }
}

class NewsForCategorie {
  List<Article> news = [];

  Future<void> getNewsForCategory(String category) async {
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${apiKey}";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
