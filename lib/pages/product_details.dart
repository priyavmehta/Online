
import 'package:flutter/material.dart';
import 'package:priyav_mart/models/product.dart';

class ProductDetails extends StatefulWidget {

  List<Product> product = <Product>[];
  int index;

  ProductDetails(List<Product> product,int index){
    this.product = product;
    this.index = index;
  }

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  

  @override
  Widget build(BuildContext context) {
    String sizes = widget.product[widget.index].size;
    List size = sizes.substring(1,sizes.length-1).split(', ');
    String colors = widget.product[widget.index].colors;
    //print(colors);
    List color = colors.substring(1,colors.length-1).split(', ');
    //print(color);

    getColor(String color){
      //print(color);
      if(color == "yellow"){
        return Colors.yellow;
      }
      if(color == "red"){
        return Colors.red;
      }
      if(color == "blue"){
        return Colors.blue;
      }
      if(color == "green"){
        return Colors.green;
      }
      if(color == "white"){
        return Colors.white;
      }
      else{
        return Colors.pink;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black.withOpacity(0.9),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'Category/shoes.jpg',
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                          onPressed: (){
                            Navigator.pop(context);
                          }
                        )
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.shopping_cart),
                              ),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.favorite_border),
                              ),
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container()
                      )
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
                            child: Text(
                              "${widget.product[widget.index].name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,10.0,20.0,10.0),
                            child: Text(
                              "Rs. ${widget.product[widget.index].price}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
             
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(2, 5),
                        blurRadius: 10
                      )
                    ]
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0,),

                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text('Available Colors : ',style: TextStyle(color: Colors.white),),
                            ),
                            Container(
                              height: 50.0,
                              width: 200.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: color.length,
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: CircleAvatar(
                                        backgroundColor: getColor(color[index]),
                                      ),
                                    ),),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text('Available Sizes : ',style: TextStyle(color: Colors.white),),
                            ),
                            Container(
                              height: 50.0,
                              width: 200.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: size.length,
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0,14.0,8.0,8.0),
                                    child: Container(width: 24, height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(
                                          size[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white,fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text('Brand : ',style: TextStyle(color: Colors.white),),
                            ),
                            Padding(
                              
                              padding: const EdgeInsets.all(8.0),
                              child: Container(width: 100, height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(7)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    widget.product[widget.index].brand,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.white,fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text('Category : ',style: TextStyle(color: Colors.white),),
                            ),
                            Padding(
                              
                              padding: const EdgeInsets.all(8.0),
                              child: Container(width: 100, height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(7)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    widget.product[widget.index].category,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.white,fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.0,),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: (){},
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Buy Now",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        )
      )
    );
  }
}

