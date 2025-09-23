import 'package:flutter/material.dart';
import 'package:newsapp/homepage.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:EdgeInsets.symmetric(horizontal:10.0, vertical: 10.0),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              borderRadius:BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius:BorderRadius.circular(30),
                      child: Image.asset("images/health.jpg",
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height/1.7,
              fit: BoxFit.cover,),
                      ),
            ),
        SizedBox(height: 20.0,),
        //Text("News from all over the world",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
        Center(child: Text("News from all over the world can be read here",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25))),
        SizedBox(height: 40.0,),
        Container(
          width:MediaQuery.of(context).size.width/1.2,       
          child: Material(
            
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),);
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,minimumSize: Size(150, 10),
                  padding: EdgeInsets.symmetric(horizontal: 85, vertical: 15),
                  ),
              child: Text("Get Started",style:TextStyle(color: Colors.white, fontSize:30.0, fontWeight: FontWeight.w500 ),
              ),
              ),
            ),
            ),
          ),
        
      ],
      ),
      )
    );
  }
}