import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:newsapp/models/slider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Sliders{
  List<sliderModel> sliders=[];
  Future<void> getSliders()async{
    String url="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=${dotenv.env['BREAKING_API_KEY']}";
    var response= await http.get(Uri.parse(url));
    var jsonData= convert.jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          sliderModel slidermodel= sliderModel(
            title: element["title"],
            description: element["description"],
            url:element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders.add(slidermodel);
        }

      });
    }
  }
}