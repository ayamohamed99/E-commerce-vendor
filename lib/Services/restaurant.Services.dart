import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/common/Repository.dart';

class RestaurantService {
  Repository _rep = Repository("restaurant");
  final String rId;
  List<RestaurantDetail> restaurant;

  final db = Firestore.instance.collection("restaurant");

  RestaurantService({this.rId});

  Future addRestaurant(RestaurantDetail data) async {
    return await _rep.addDocument(data.toJson());
  }

  Future<List<RestaurantDetail>> fetchData() async {
    var result = await _rep.getDataCollection();
    restaurant = result.documents
        .map((doc) => RestaurantDetail.fromMap(doc.data, doc.documentID))
        .toList();
    return restaurant;
  }

  Future<void> removeDocument(String id) async {
    return await _rep.removeDocument(id);
  }

  Future update(RestaurantDetail data, String rId) async {
    return await _rep.updateDocument(data.toJson(), rId);
  }

  Future<RestaurantDetail> getById(String rId) async {
    var result = await db.where("rId", isEqualTo: rId).getDocuments();
    var restaurant = result.documents.first;
    return RestaurantDetail.fromMap(restaurant.data, restaurant.documentID);
  }
}
