import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//own imports
import 'package:priyav_mart/components/Products.dart';
import 'package:priyav_mart/components/horizontal_listView.dart';
import 'package:priyav_mart/database/products.dart';
import 'package:priyav_mart/models/product.dart';
import 'package:priyav_mart/pages/cart.dart';
import 'package:priyav_mart/pages/login.dart';
import 'package:priyav_mart/provider/app_provider.dart';
import 'package:provider/provider.dart';
import '../components/featuredProducts.dart';
import 'account.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference collectionReference = Firestore.instance.collection("products");
  String collection = 'products';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _searchController = TextEditingController();
  List<Product> products = <Product>[];
  ProductService _productService = ProductService();
  List<DocumentSnapshot> snapshots = <DocumentSnapshot>[];
  StreamSubscription<QuerySnapshot> subscription;
  List<Product> featuredProducts = <Product>[];
  String name;
  String email;
  CollectionReference collectionCategory = Firestore.instance.collection("categories");
  List<DocumentSnapshot> snapshotCategory = <DocumentSnapshot>[];
  StreamSubscription<QuerySnapshot> subscriptionCategory;
  List<String> categories = <String>[];

  @override
  void initState() {
    super.initState();
    
    List<DocumentSnapshot> snaps = <DocumentSnapshot>[];
    subscription = collectionReference.snapshots().listen((dataSnapshots){
      setState(() {
        snapshots = dataSnapshots.documents;
        List<Product> prod = <Product>[];
        List<Product> prod1 = <Product>[];
        print(snapshots.length.toString());
        for (var i = 0; i < snapshots.length; i++) {
          Product product = Product.fromSnapshot(snapshots[i]);
          prod.add(product);
          if(product.featured == true){
            prod1.add(product);
          }
        }
        setState(() {
          products = prod;
          featuredProducts = prod1;
        });
      });
    });
    getCurrentUser();

    subscriptionCategory = collectionCategory.snapshots().listen((dataSnapshots){
      setState(() {
        snapshotCategory = dataSnapshots.documents;
        List<String> cats = <String>[];
        for (var i = 0; i < snapshotCategory.length; i++) {
          cats.add(snapshotCategory[i].data['category']);
        }
        setState(() {
          categories = cats;
          print(categories);
        });
      });
    });
    
  }

  getCurrentUser() async{
    FirebaseUser firebaseUser = await firebaseAuth.currentUser().then((user){
      setState(() {
        name = user.displayName;
        email = user.email;
      });
    });
    
  }

  _getsnapshots() async{
    print("in snapshots");
    List<DocumentSnapshot> snaps = <DocumentSnapshot>[];
    snaps = await _productService.getSnapshots();
    setState(() {
      snapshots = snaps;
    });
    print("after getiing snapshots");
    List<Product> prod = <Product>[];
    for (var i = 0; i < snapshots.length; i++) {
      Product product = Product.fromSnapshot(snapshots[i]);
      prod.add(Product.fromSnapshot(snapshots[i]));
      //print(product.size.substring(1,product.size.length-1).split(', '));
      print(product.colors.substring(1,product.colors.length-1).split(', '));
    }
    setState(() {
      products = prod;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    //Creating Image Carousel
    Widget image_carousel = new Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('carousel/cliff.jpg'),
          AssetImage('carousel/lake.jpg'),
          AssetImage('carousel/landscape.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        dotBgColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );

    return Scaffold(
      //Creating the Appbar
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        //title of bar
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[50],
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintText: "Search...",
                border: InputBorder.none
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "The search field cannot be empty";
                }
                return null;
              },
            ),
          )
        ),
        //trailing icons
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.black,
            onPressed: (){
              _getsnapshots();
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.black,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()));
            },
          ),
        ],
      ),
      //Nav Drawer
      drawer: Drawer(
        //creating drawer lists
        child: ListView(
          children: <Widget>[
            //header
            UserAccountsDrawerHeader(
              accountName: Text("Priyav Mehta"),
              accountEmail: Text("priyavmehta7@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: BoxDecoration(color: Colors.black),
            ),
            //Body
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              },
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home, color: Colors.black,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context , MaterialPageRoute(builder: (context)=>Account()));
              },
              child: ListTile(
                title: Text("My Account"),
                leading: Icon(Icons.person, color: Colors.black,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("My Orders"),
                leading: Icon(Icons.shopping_basket, color: Colors.black,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()));
              },
              child: ListTile(
                title: Text("Shopping Cart"),
                leading: Icon(Icons.shopping_cart, color: Colors.black,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("Favourites"),
                leading: Icon(Icons.favorite, color: Colors.red,),
              ),
            ),

            Divider(),
            InkWell(
              onTap: (){
                firebaseAuth.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              },
              child: ListTile(
                title: Text("Sign Out"),
                leading: Icon(Icons.help, color: Colors.green,),
              ),
            ),
          ],
        ),
      ),
      //body
      body: ListView(
        children: <Widget>[
          // image carousel
          image_carousel,
          //Padding
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Categories'),
          ),
          
          //horizontal list of items
          HorizontalList(categories),

          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Featured Products'),
          ),
          FeaturedProducts(featuredProducts),
 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,20.0,8.0,9.0),
                child: Text('Recent Products',
                style: TextStyle(color: Colors.black),),
              ),
            ]
          ),

          Container(
            height: 320.0,
            child: Products(products),
          )
        ],
      ),
    );
  }
}