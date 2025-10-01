 import 'package:newsapp/categorynews/categorymod.dart';

List<Categorymod> Categoriess(){
  List<Categorymod> category=[];
  Categorymod categorymod = new Categorymod();

  categorymod.categoryName="Business";
  categorymod.image="images/business.jpg";
  category.add(categorymod);
  categorymod=new Categorymod();

  categorymod.categoryName="Entertainment";
  categorymod.image="images/entertainment.jpg";
  category.add(categorymod);
  categorymod=new Categorymod();

  categorymod.categoryName="Health";
  categorymod.image="images/health.jpg";
  category.add(categorymod);
  categorymod=new Categorymod();

  categorymod.categoryName="Science";
  categorymod.image="images/science.jpg";
  category.add(categorymod);
  categorymod=new Categorymod();

  categorymod.categoryName="Sports";
  categorymod.image="images/sports.jpg";
  category.add(categorymod);
  categorymod=new Categorymod();

  return category;
 }