import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/categoryDetail.dart';
import 'package:ecommerce/common/Repository.dart';

class CategoryService{

  Repository _rep = Repository("category");
  final String cId;
  List<CategoryDetail> category;

  final db = Firestore.instance.collection("category");
  CategoryService({this.cId});

  Future addCategory(CategoryDetail data) async {
    return await _rep.addDocument(data.toJson());
  }

  Future <List<CategoryDetail>> fetchData() async {
    var result = await _rep.getDataCollection();
    category = result.documents.map((doc) => CategoryDetail.fromMap(doc.data, doc.documentID)).toList();
    return category;

  }

  Future<void> removeDocument(String id) async{
return await _rep.removeDocument(id);
  }
  Future update(CategoryDetail data , String cId) async {
    return await _rep.updateDocument(data.toJson(), cId);
  }

  Future<CategoryDetail> getById(String cId) async{
    var result = await db.where("cId" , isEqualTo: cId).getDocuments();
    var category = result.documents.first;
    return CategoryDetail.fromMap(category.data, category.documentID);
  }
}