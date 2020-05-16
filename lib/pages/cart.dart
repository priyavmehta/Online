import 'package:flutter/material.dart';

//own imports
import 'package:priyav_mart/components/cart_Products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        //title of bar
        title: Text("Priyav Mart"),
        //trailing icons
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: (){},
          ),
        ],
      ),
      
      body: CartProducts(),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              
              child: ListTile(
                title: Text("Total"),
                subtitle: Text("\$230"),
              )
            ),
            Expanded(
              child: MaterialButton(
                onPressed: (){},
                child: Text(
                  "Proceed to Buy",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                color: Colors.red,
                shape: StadiumBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }
}