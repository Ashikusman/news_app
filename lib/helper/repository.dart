import 'dart:convert';

import 'package:news_app/models/Article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = <ArticleModel>[];

  Future<void> getAllNews() async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d391cba16a5246aaa63b8575564a7b8f";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null) {
            ArticleModel articleModel = ArticleModel();
              articleModel.author = element['author'];
              articleModel.title = element['title'];
              articleModel.description =element['description'];
              articleModel.url=element['url'];
              articleModel.urlToImage=element['urlToImage'];
              articleModel.content=element ['content'];

            news.add(articleModel);
        }
      });
    }
  }

}

class NewsCategory {
  List<ArticleModel> newsCategory = <ArticleModel>[];

  Future<void> getCategoryNews(String category) async {
    String url = "https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=d391cba16a5246aaa63b8575564a7b8f";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null) {
          ArticleModel articleModel = ArticleModel();
          articleModel.author = element['author'];
          articleModel.title = element['title'];
          articleModel.description =element['description'];
          articleModel.url=element['url'];
          articleModel.urlToImage=element['urlToImage'];
          articleModel.content=element ['content'];

          newsCategory.add(articleModel);
        }
      });
    }
  }
}

class NewsSearch{
  List<ArticleModel> searchNews = <ArticleModel>[];

  Future<void> getSearchNews(String query) async {
    String url = "https://newsapi.org/v2/everything?q=$query&from=2022-12-18&sortBy=popularity&apiKey=d391cba16a5246aaa63b8575564a7b8f";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null) {
          ArticleModel articleModel = ArticleModel();
          articleModel.author = element['author'];
          articleModel.title = element['title'];
          articleModel.description =element['description'];
          articleModel.url=element['url'];
          articleModel.urlToImage=element['urlToImage'];
          articleModel.content=element ['content'];

          searchNews.add(articleModel);
        }
      });
    }
  }
}
