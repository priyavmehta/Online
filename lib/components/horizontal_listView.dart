import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {

  List<String> categories = <String>[];

  HorizontalList(List<String> categories){
    this.categories = categories;
  }

  getImage(String category){
    if(category == "Jeans"){
      return "Category/jeans.jpg";
    }
    else if(category == "T-shirts"){
      return "Category/t_shirt.jpg";
    }
    else if(category == "Ladies"){
      return "Category/dress.jpg";
    }
    else if(category == "Formals"){
      return "Category/formals.jpg";
    }
    else if(category == "Informals"){
      return "Category/informals.jpg";
    }
    else if(category == "Shoes"){
      return "Category/shoes.jpg";
    }
    else if(category == "Accesories"){
      return "Category/accesories.jpg";
    }
    else{
      return "Category/back.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context,index){
          return Category(
            imageCaption: categories[index],
            imageLocation: getImage(categories[index]),
          );
        },
      ),
    );
  }
}

class Category extends StatelessWidget {

  String imageLocation;
  String imageCaption; 

  Category({
    this.imageLocation,
    this.imageCaption
  }); 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: (){},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              imageLocation, 
              width: 80.0, 
              height: 80.0,
              fit: BoxFit.fill,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(imageCaption),
            ),
          ),
        ),
      ),
    );
  }
}