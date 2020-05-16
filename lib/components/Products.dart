import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:priyav_mart/models/product.dart';
import 'package:priyav_mart/pages/product_details.dart';

class Products extends StatefulWidget {

  List<Product> prods = <Product>[];
  Products(List<Product> prods){
    this.prods = prods;
  }

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.prods.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return SingleProducts(
          prodImage: 'Category/formals.jpg',
          prodName: widget.prods[index].name,
          prodPrice: widget.prods[index].price,
          prod : widget.prods,
          index: index
        );
      },
    );
  }
}

class SingleProducts extends StatelessWidget {
  String prodName;
  double prodPrice;
  String prodImage;
  int index;
  List<Product> prod = <Product>[];

  SingleProducts(
      {this.prodName, this.prodImage, this.prodPrice, this.prod,this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(6.0),
        child: Material(
          child: InkWell(
            onTap: ()=> Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> ProductDetails(prod,index))),
            child: GridTile(
              footer: Container(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    prodName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0
                    ),
                  ),
                  trailing: Text("Rs $prodPrice",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0
                    ),
                  ),
                ),
              ),
              child: Image.asset(
                prodImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
    );
  }
}
