class CategoryDetail{
  String cId;
  String categoryName;

  CategoryDetail({this.cId , this.categoryName});

  CategoryDetail.fromMap(Map snapshot , String id)
  : cId = id?? '',
  categoryName = snapshot['categoryName']?? '';
  
  toJson(){
    return{
      "cId" : cId,
      "categoryName" : categoryName,
    };
  }
}