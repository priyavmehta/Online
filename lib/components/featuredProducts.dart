import 'package:flutter/material.dart';
import 'package:priyav_mart/models/product.dart';
import 'featured_card.dart';

class FeaturedProducts extends StatefulWidget {
  List<Product> products;

  FeaturedProducts(List<Product> products){
    this.products = products;
  }

  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      //230
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.products.length,
        itemBuilder: (_, index) {
          return FeaturedCard(
            name: widget.products[index].name,
            price: widget.products[index].price,
            picture: '',
            product: widget.products,
            index: index
          );
        }
      )
    );
  }
}