import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {

  var Products_in_Cart=[
    {
      "name": "Blazer",
      "picture": "Category/formals.jpg",
      "price": 10000,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Blazer",
      "picture": "Category/dress.jpg",
      "price": 10000,
      "size": "S",
      "color": "Green",
      "quantity": 2,
    },
    {
      "name": "Blazer",
      "picture": "Category/jeans.jpg",
      "price": 10000,
      "size": "XL",
      "color": "Blue",
      "quantity": 1,
    },
    {
      "name": "Blazer",
      "picture": "Category/dress.jpg",
      "price": 10000,
      "size": "S",
      "color": "Yellow",
      "quantity": 4,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Products_in_Cart.length,
      itemBuilder: (context, index){
        return Single_Product_Cart(
          prodNameCart: Products_in_Cart[index]["name"],
          prodImageCart: Products_in_Cart[index]["picture"],
          prodPriceCart: Products_in_Cart[index]["price"],
          prodColorCart: Products_in_Cart[index]["color"],
          prodQuantityCart: Products_in_Cart[index]["quantity"],
          prodSizeCart: Products_in_Cart[index]["size"],
        );
      }
    );
  }
}

class Single_Product_Cart extends StatelessWidget {

  String prodNameCart;
  String prodImageCart;
  String prodSizeCart;
  int prodQuantityCart;
  String prodColorCart;
  int prodPriceCart;

  Single_Product_Cart({
    this.prodNameCart,
    this.prodImageCart,
    this.prodPriceCart,
    this.prodColorCart,
    this.prodQuantityCart,
    this.prodSizeCart
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
            prodImageCart,
            fit: BoxFit.cover,
        ),
        title: Text(prodNameCart),
        subtitle: Column(
          children: <Widget>[

          // Row inside a Column
            Row(
              children: <Widget>[
                //This is for size
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text("Size"),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(prodSizeCart, style: TextStyle(color: Colors.red),),
                ),

                // This is for Color
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: Text("Color"),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(prodColorCart, style: TextStyle(color: Colors.red),),
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Rs ${prodPriceCart}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
        trailing: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: (){},
            ),
            Text("${prodQuantityCart}"),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }
}