import 'package:http/http.dart' as http;
import 'package:newsapp/show_category.dart';
import 'dart:convert' as convert;
// ignore: unused_import
import 'package:newsapp/slider.dart';

class ShowCategoryNews{
  List<ShowCategoryModel> categories=[];
  Future<void> getCategoriesNews(String category)async{
    String url=
    "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=f3fa0e980bad4535b4cb46240586511b";
    var response= await http.get(Uri.parse(url));
    var jsonData= convert.jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          ShowCategoryModel categoryModel= ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url:element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(categoryModel);
        }

      });
    }
  }
}