class RestaurantDetail {
  String name;
  String location;
  String img;
  num rate;
  String hotline;
  String categoryN;
  String catId;
  String rId;
  num numSeats;
  num numTables;
  List<num> timeRes;
  // num hit;
  String headline;
  String description;
  // String imgUrl;
  

  RestaurantDetail(
      {this.name,this.description,this.numSeats,this.numTables,//this.timeRes,
       this.location, this.img, this.headline, 
       this.rate, this.rId, this.catId , 
        this.hotline , this.categoryN ,
        //  this.imgUrl 
         });

  RestaurantDetail.fromMap(Map snapshot, String id)
      : rId = id ?? '',
        name = snapshot['name'] ?? '',
        location = snapshot['location'] ?? '',
        img = snapshot['img'] ?? '',
        // imgUrl = snapshot['imgUrl']?? '',
        headline = snapshot['headline'] ?? '',
        catId = snapshot['catId'] ??'',
        rate = snapshot['rate'] ?? '' ,
         categoryN = snapshot['categoryN'] ?? '' ,
        hotline = snapshot['hotline'] ?? '' ,
        numSeats = snapshot['numSeats']??'',
        numTables = snapshot['numTables']??'',
        //timeRes=snapshot['timeRes']??'',
        description=snapshot['description']??'';

        

  toJson() {
    return {
      "rId": rId,
      "name": name,
      "location": location,
      "img": img,
      // "imgUrl": imgUrl,
      "catId":catId,
      "rate": rate,
      "categoryN" :categoryN,
      "numSeats":numSeats,
      "numTables":numTables,
      //"timeRes": timeRes,
      "description":description,
      "headline" : headline,
      "hotline" : hotline
    };
  }
}
