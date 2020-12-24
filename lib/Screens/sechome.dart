import 'package:ecommerce/Components/loading.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/Screens/home/home.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SecHome extends StatefulWidget {
  SecHome(this.rId);

  final String rId;

  @override
  _SecHomeState createState() => _SecHomeState(this.rId);
}

class _SecHomeState extends State<SecHome> {

Future<void>_showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('HOTLINE'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('If you faced a problem and you need to contact with us Please Call  this number it is  an easy fast way to contact with us '
              + '\n\n'+restaurant.hotline,
              style: TextStyle(fontSize: 18,
                
              ),
              ), 
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: Text('Close',
            style: TextStyle(fontSize: 20 ,
                fontWeight: FontWeight.w500)
            
            ),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
        ],
      );
    },
  );
}


  String rId;
  var restaurantV;
  _SecHomeState(this.rId);

  RestaurantDetail restaurant;
  RestaurantService resServ = new RestaurantService();
  // ignore: missing_return
  Future<RestaurantDetail> _fetchRestaurantData() async {
    restaurantV = await resServ.getById(this.rId);
    refresh();
  }

  void refresh() {
    setState(() {
      restaurant = restaurantV;
    });
  }

  // ignore: must_call_super
  void initState() {
    _fetchRestaurantData();
  }

  bool _visible = false;

  // ignore: non_constant_identifier_names
  Container _MyCard(String resImg, String resName, String resDesc,
      String resHeadline,String adress) {
    return Container(
        color: Colors.white,
        width: 150.0,
        child: Column(children: [
          Container(
            margin: EdgeInsets.all(20),
            height: 250,
            child: Image.asset(
              resImg,
              fit: BoxFit.fill,
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                _visible = true;
              });
            },
            title: Text(resHeadline,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.5,
                    fontStyle: FontStyle.italic),
                  ),
          ),
        
          Visibility(
            visible: _visible,
            child: ListTile(
              onTap: () {
                setState(() {
                  _visible = !_visible;
                });
              },
              subtitle: Text('Read less',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.red[500],
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      fontStyle: FontStyle.normal)),
              title: Text(resDesc,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      height: 1.5,
                      fontStyle: FontStyle.italic)),
            ),
          ),
          SizedBox(height: 25,),
          RaisedButton(
        padding: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.green[500],
            onPressed: (){}, 
          child: Text('BOOK' , 

          style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white),))
          
        ]));
  }

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) return Loading();
    return Scaffold(
      drawer: Drawer(
            child: Column(
              
              children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.all(8),
            color: Colors.green[500],
            child: Center(
                child: Text(
              restaurant.name,
              style: TextStyle(fontSize: 25,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.white,
               height: 3,
              
              ),
            )),
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.only(right: 150),
          child:  FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(Icons.home,),
              label: Text(
                'Home',
                style: TextStyle(fontSize: 25,
                fontWeight: FontWeight.bold,
                ),
                
              )),
          ),
          
              SizedBox(height: 30,),
             
          Container(
            padding: EdgeInsets.only(right:35),
            child:  Row(
             children: [
               SizedBox(width:30,),
               Text('Rate  ',
                style: TextStyle(fontSize: 25 , color: Colors.black,
                fontWeight: FontWeight.w500),),
                Card(
                  child:SmoothStarRating(
                    isReadOnly: true,
                    size: 20,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    color: Colors.yellow[900],
                    borderColor: Colors.yellow[900],
                    allowHalfRating: true,
                    spacing: 2.0,
                    onRated: null,
                  ),
                ),
               
             ],
           ),
          ),
            SizedBox(height: 30,),

         Container(
           padding: EdgeInsets.only(right:90),
           child:  FlatButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.utensils),
              label: Text(
                restaurant.categoryN,
                style: TextStyle(fontSize: 25),
              )),),
              SizedBox(height: 30,),
               Container(
                 padding: EdgeInsets.only(right:70),
         child: FlatButton.icon(
              onPressed: _showMyDialog,
              icon: Icon(FontAwesomeIcons.phoneAlt),
              label: Text(
                ' Contact us ',
                style: TextStyle(fontSize: 25,
                ),
              )),),
              
        ])),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(restaurant.name),
        backgroundColor: Colors.green[400],
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                child: _MyCard(
                    restaurant.img,
                    restaurant.name,
                    restaurant.description,
                    restaurant.headline,
                    restaurant.location
                    ),
              ),
            ],
          )),
    );
  }
}
