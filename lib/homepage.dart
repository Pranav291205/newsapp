import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsapp/all_news.dart';
import 'package:newsapp/article.dart';
import 'package:newsapp/articleview.dart';
import 'package:newsapp/category_news.dart';
import 'package:newsapp/categorymod.dart';
import 'package:newsapp/data.dart';
import 'package:newsapp/landingpage.dart';
import 'package:newsapp/news.dart';
import 'package:newsapp/slider.dart';
import 'package:newsapp/sliderdata.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Categorymod> categories=[];
  List<sliderModel> sliders=[];
  List<Article> articles=[];
  bool loading=true;

  int activeIndex=0;
  @override
  void initState(){
    categories= Categoriess();
    getSliders();
    getNews();
    super.initState();
  }
  getNews() async{
    News newsclass =News();
    await newsclass.gNews();
    articles=newsclass.news;
    setState(() {
      loading=false;
    });
  }
  getSliders() async{
    Sliders slider =Sliders();
    await slider.getSliders();
    sliders=slider.sliders;
  }
  // ignore: unused_element
  Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Landingpage()),
    (route) => false,
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
              )
              ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Landingpage()),
      (route) => false,
    );
  },
  tooltip: 'Sign Out',
  backgroundColor: const Color.fromARGB(255, 186, 198, 215),
  child: const Icon(Icons.exit_to_app),
),

      body: loading? Center(child: SizedBox(height: 100.0,width: 70.0,
        child:SpinKitThreeInOut(
                    color: Colors.blue,
                    size: 40.0,
                  ),
      )): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              height: 90,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length, 
                itemBuilder: (context, index) {
            return Category(
              image: categories[index].image,
              categoryName: categories[index].categoryName,
            );
                }),
            ),
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ 
                Text("Breaking News!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize:20.0),),
                GestureDetector(
                  onTap: () {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text(
          "Breaking News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: loading?
              Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: SpinKitThreeInOut(
                    color:Colors.blue,
                    size: 40.0,
                  ),
                ),
              )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: sliders.length,
                    itemBuilder: (context, index) {
                      final article = sliders[index];
                      return AllNewsSection(
                        image: article.urlToImage ?? '',
                        desc: article.description ?? '',
                        title: article.title ?? '',
                        url: article.url ?? '',
                      );
                    },
                  ),
      ),
    ),
  ));
},

                  child: Text("View All",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                    fontSize:18.0),
                    ),
                ),
            ])),
            SizedBox(height: 30.0,),
            CarouselSlider.builder(
              itemCount: 5, 
              itemBuilder: (context, index, realIndex){
              String? res=sliders[index].urlToImage;
              String? res1=sliders[index].title;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: sliders[index].url!)));
                      },
                    child: buildImage(res!, index, res1!)),
                    //SizedBox(height: 300.0,),
                  ],
                ),
            );
            },
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged:(index,reason){
                setState((){
                  activeIndex=index;
                });
              }
            )
          ),       
            SizedBox(
              height: 30.0,
            ),
          Center(child: buildIndicator()),
          SizedBox(height: 30,),
          Padding(padding: const EdgeInsets.only(left:10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Treding News!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize:20.0),),
                GestureDetector(
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: loading
            ? Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                    child: SpinKitThreeInOut(
                      color: const Color.fromARGB(255, 55, 61, 179),
                      size: 40.0,
                    ),
                  
                ),
              )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return AllNewsSection(
                        image: article.urlToImage ?? '',
                        desc: article.description ?? '',
                        title: article.title ?? '',
                        url: article.url ?? '',
                      );
                    },
                  ),
                  ),
    ),
  ));
},  
                  child: Text("View All",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                    fontSize:18.0),),
                ),
            ],
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                ],),
              ),
            ),
          ),
          SizedBox(height: 10.0,),  
          Container(
            child: ListView.builder(
              shrinkWrap:true,
              physics:ClampingScrollPhysics(),
              itemCount: articles.length, itemBuilder:(context, index) {
              return BlogTile(
                url:articles[index].url!,
                desc: articles[index].description!,
                imageurl: articles[index].urlToImage!,
                title:articles[index].title!);
            }
          ),
          )   
          ],
          ),
        ),
      ),
    );
  }
    Widget buildImage(String image,int index,String name)=>
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0,),
    child: Stack(
      children: [
      ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 200,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          ),
      ),
      Container(
        padding: EdgeInsets.only(left: 10.0),
        margin: EdgeInsets.only(top: 150.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6))),
        child:Text(
          name,
          maxLines:2,
          style: TextStyle(color: Colors.white,fontSize: 17.0, fontWeight: FontWeight.bold)),
      )
      ]
    ),
    );
    Widget buildIndicator()=> AnimatedSmoothIndicator(
      activeIndex: activeIndex,
       count: 5,
       effect: SlideEffect(dotWidth: 10, dotHeight: 10, activeDotColor: Colors.blue));
}

class Category extends StatelessWidget {
  final image, categoryName;
  Category({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Stack(children:[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child:Image.asset(
              image,
            width:170,
            height:120,
            fit: BoxFit.cover, 
            ),
            ),
            Container(
              width: 170,
              height:120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,),
              child: Center(
                child: Text(
                  categoryName,
                  style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),)
                  ),
            )
        ])
      ),
    );
  }
} 
// ignore: must_be_immutable
class BlogTile extends StatelessWidget {
  String imageurl,title,desc,url;
  BlogTile({required this.desc,required this.imageurl, required this.title,required this.url,});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
            },
             child: Container(
              margin:EdgeInsets.only(bottom: 10.0),
               child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: imageurl,
                            height:120,
                            width: 120,
                            fit: BoxFit.cover,))),
                      SizedBox(width: 8.0,),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/1.7,
                            child: Text(
                              title,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize:18.0),
                                ),
                          ),
                          SizedBox(height: 7.0,),
                           Container(
                            width: MediaQuery.of(context).size.width/1.7,
                            child: Text(
                              desc,
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize:17.0),
                                ),
                          ),
                        ],
                      ),
                    ],),
                  ),
                ),
                         ),
             ),
           );
  }
}