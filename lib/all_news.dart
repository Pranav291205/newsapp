import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/article.dart';
import 'package:newsapp/articleview.dart';
import 'package:newsapp/news.dart';
import 'package:newsapp/slider.dart';
import 'package:newsapp/sliderdata.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {

  List<sliderModel> sliders=[];
  List<Article> articles=[];
  bool loading=true;
    @override
    void initState(){
    getSliders();
    getNews();
    super.initState();
  }
  
  getNews() async{
    News newsclass =News();
    await newsclass.gNews();
    articles=newsclass.news;
    loading= false;
  }
  getSliders() async{
    Sliders slider =Sliders();
    await slider.getSliders();
    sliders=slider.sliders;
    loading=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
              "${widget.news} News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
              ),
              centerTitle: true,
              elevation: 0.0,
      ), 
      body: Container(child:loading?
      Center(child: CircularProgressIndicator()):
             ListView.builder(
                shrinkWrap:true,
                physics:ClampingScrollPhysics(),
                itemCount: widget.news=="Breaking"?  sliders.length: articles.length,
                itemBuilder:(context,index){
                  return AllNewsSection(
                    image: widget.news=="Breaking"? sliders[index].urlToImage!: articles[index].urlToImage!,
                   desc: widget.news=="Breaking"? sliders[index].description!: articles[index].description!,
                    title: widget.news=="Breaking"? sliders[index].title!: articles[index].title!,
                     url: widget.news=="Breaking"? sliders[index].url!: articles[index].url!, 
                    );
                }
        ),
      ),
      );
  }
}
class AllNewsSection extends StatelessWidget {
  final String image,desc,title,url;
  AllNewsSection({required this.image,required this.desc,required this.title,required this.url,Key?key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
              CachedNetworkImage(imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200, 
              fit: BoxFit.cover,),),
              Text(title,
              maxLines:2,
              style:TextStyle(color: Colors.black,fontSize: 18.0, fontWeight: FontWeight.bold)),
              Text(desc,maxLines:3,),
              SizedBox(height: 5.0,),
        ],),
      ),
    );
  }
}