import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsapp/web_view/articleview.dart';
import 'package:newsapp/models/show_category.dart';
import 'package:newsapp/api_calls/show_category_news.dart';

// ignore: must_be_immutable
class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ShowCategoryModel> categories=[];
  bool loading=true;

  @override
  void initState(){
    super.initState();
    getNews();
  }
   getNews() async{
    ShowCategoryNews showCategoryNews =ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories=showCategoryNews.categories;
    setState(() {
      loading=false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
              widget.name,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
              ),
              centerTitle: true,
              elevation: 0.0,
      ), 
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: loading? Center(child: SizedBox(height: 100.0,width: 70.0,
              child:SpinKitThreeInOut(
                    color: Colors.blue,
                    size: 40.0,
                  ),
                  
            )
            )
            :ListView.builder(
              shrinkWrap:true,
              physics:ClampingScrollPhysics(),
              itemCount: categories.length, itemBuilder:(context, index) {
              return ShowCategory(
                image: categories[index].urlToImage!,desc: categories[index].description!,title: categories[index].title!,url:categories[index].url!,
              );
            }
          ),
          ),
    );
  }
}
class ShowCategory extends StatelessWidget {
  final String image, desc, title, url;
  const ShowCategory({super.key, required this.image, required this.desc, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0), 
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400, 
            width: 1.2, 
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withValues(alpha:0.3), 
        spreadRadius: 2,  
        blurRadius: 6,     
        offset: Offset(0, 3), 
      ),
    ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white, // background for text area
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
