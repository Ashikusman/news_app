import 'package:flutter/material.dart';
import 'package:news_app/helper/repository.dart';

import '../models/Article_model.dart';

class CategoryNews extends StatefulWidget {
  final category;
  const CategoryNews({super.key, this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];

  getNewsCategory() async{
    NewsCategory newsHelper = NewsCategory();
    await newsHelper.getCategoryNews(widget.category);
    articles = newsHelper.newsCategory;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsCategory();
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
