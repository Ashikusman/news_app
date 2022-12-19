import 'package:flutter/material.dart';

import '../helper/repository.dart';
import '../models/Article_model.dart';

class SearchNews extends StatefulWidget {
  final search;
  const SearchNews({super.key, this.search});

  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  List<ArticleModel> articles = <ArticleModel>[];

  getNewsSearch() async{
    NewsSearch newsHelper = NewsSearch();
    await newsHelper.getSearchNews(widget.search);
    articles = newsHelper.searchNews;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          child: Column(
            children: <Widget> [
              //News Card
              Container(
                padding: const EdgeInsets.only(top:15),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(), //scroller
                    itemBuilder: (context,index) {
                      return NewsCard(
                        imageUrl: articles[index].urlToImage ?? '',
                        title: articles[index].title ?? '',
                        desc: articles[index].description ?? '',
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String imageUrl, title, desc;
  const NewsCard({required this.imageUrl,required this.title,required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Image.network(imageUrl),
          Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(desc,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
