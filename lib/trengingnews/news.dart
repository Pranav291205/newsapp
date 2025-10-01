import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:newsapp/trengingnews/article.dart';

class News{
  List<Article> news=[];
  Future<void> gNews()async{
    String url="https://newsapi.org/v2/everything?domains=wsj.com&apiKey=${dotenv.env['TRENDING_API_KEY']}";
    var response= await http.get(Uri.parse(url));
    var jsonData= convert.jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          Article articlemod= Article(
            title: element["title"],
            description: element["description"],
            url:element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          
          news.add(articlemod);
        }

      });
    }
  }
}