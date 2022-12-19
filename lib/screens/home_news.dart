import 'package:flutter/material.dart';
import 'package:news_app/helper/categories.dart';
import 'package:news_app/models/Category_model.dart';
import 'package:news_app/screens/category_news.dart';
import 'package:news_app/screens/headlines_news.dart';
import 'package:news_app/screens/search_news.dart';

import '../models/Article_model.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  late List<CategoryModel> newsCategories = <CategoryModel>[];
  final searchController =TextEditingController();
  //Validate search field
  bool validateSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsCategories = getCategories();
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
              //Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 80,
                decoration: const BoxDecoration(
                    color: Colors.white,

                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: TextField(
                            controller: searchController,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search News",
                                errorText: validateSearch? 'Search field required' : null,
                            ),
                          ),
                        ),
                    ),
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            searchController.text.isEmpty?validateSearch=true:validateSearch=false;
                          });
                          if(validateSearch==false) {
                            var article = ArticleModel();
                            article.title = searchController.text;
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SearchNews(
                                  search: article.title,
                                )));
                            searchController.clear();
                          }
                        },
                        icon: const Icon(Icons.search_sharp),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('All Categories',
                style: TextStyle(
                  fontSize: 20,
                  color:Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
                width: 100.0,
                child: Divider(
                  color: Colors.teal,
                ),
              ),

              //News Categories
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 400,
                child: ListView.builder(
                    itemCount: newsCategories.length,
                    shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        imageUrl: newsCategories[index].imageUrl ?? '',
                        categoryName: newsCategories[index].categoryName ?? '',
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color:Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const HeadlinesNews()
                  ));
                },
                child: const Text('View Top Headlines'),
              ),
              const SizedBox(
                height: 10,

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {

  final imageUrl, categoryName;
  CategoryCard({this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName,
            )));
      },
      child: Container(
        margin:EdgeInsets.only(bottom: 10),
        child: Stack(
          children: <Widget>[
            Image.network(imageUrl),
            Container(
              width: 300,
              height: 200,
              alignment: Alignment.center,
              child: Text(
                categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


