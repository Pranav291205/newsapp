import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/viewall/articleview.dart';
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