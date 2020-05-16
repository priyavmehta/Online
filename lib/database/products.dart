import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService{
  Firestore _firestore = Firestore.instance;
  String collection = 'products';

  Future<List<Product>> getFeaturedProducts() =>
    _firestore.collection(collection)
    .getDocuments()
    .then((snap){
      List<Product> featuredProducts = [];
      snap.documents.map((snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
      return featuredProducts;
    });

  Future<List<DocumentSnapshot>> getSnapshots(){
    return _firestore.collection("products").getDocuments()
    .then((snap){
      return snap.documents;
    });

  }
}