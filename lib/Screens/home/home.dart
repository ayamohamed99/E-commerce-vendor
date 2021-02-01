import 'package:ecommerce/Components/loading.dart';
import 'package:ecommerce/Models/categoryDetail.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/Services/category.Services.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../Models/restaurantDetail.dart';
import '../sechome.dart';
import 'addform.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final AuthService _auth = AuthService();
  bool typing = false;
  bool loading = true;
  List<CategoryDetail> category;

  CategoryService catServ = new CategoryService();
  // ignore: missing_return
  Future<List<CategoryDetail>> _fechCategoryData() async {
    category = await catServ.fetchData();
  }

  // ignore: must_call_super
  void initState() {
    _fechCategoryData();
    _fechRestaurantData();
  }

  // bool _visible = false;

  List<RestaurantDetail> restaurant;
  List<RestaurantDetail> restaurantall;
  List<RestaurantDetail> resSort;

  RestaurantService resServ = new RestaurantService();

  // ignore: missing_return

  // ignore: missing_return
  Future<List<RestaurantDetail>> _fechRestaurantData() async {
    restaurantall = await resServ.fetchData();
    restaurant = restaurantall;
    resSort = await resServ.fetchData();
    setState(() {
      if (restaurant != null)
        loading = false;
      else
        loading = true;
    });
  }

  // // ignore: must_call_super
  // int k = 0;
  // // ignore: missing_return
  // Widget _bBuildCard() {
  //   // ignore: unnecessary_statements
  //   for (k; k < category.length; k++) {
  //     return dropdownlist(k);
  //   }
  // }

  void _onchangesearch(String str) {
    List<RestaurantDetail> temp = new List<RestaurantDetail>();
    for (RestaurantDetail rd in restaurantall) {
      if (rd.name.contains(str)) {
        temp.add(rd);
      }
    }
    setState(() {
      restaurant = temp;
    });
  }

  void _onchangesearchcat(String str) {
    List<RestaurantDetail> temp = new List<RestaurantDetail>();
    for (RestaurantDetail rd in restaurantall) {
      if (rd.categoryN == str) {
        temp.add(rd);
      }
    }
    setState(() {
      restaurant = temp;
    });
  }

  Widget dropdownlist(int k) {
    return Container(
      height: 30,
      child: Card(
        child: FlatButton(
          onPressed: () {},
          child: Text(category[k].categoryName, style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  String dropdownValue = 'Categories';

  Widget card(BuildContext context, int index) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        shadowColor: Colors.green[500],
        borderOnForeground: true,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              height: 150,
              child: Image.network(
                restaurant[restaurant.length - index - 1].img,
                fit: BoxFit.fill,
              ),
            ),
            Row(children: <Widget>[
              SizedBox(
                width: 30,
              ),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  restaurant[restaurant.length - index - 1].name,
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  setState(() async {
                    await resServ.update(
                        restaurant[restaurant.length - index - 1],
                        restaurant[restaurant.length - index - 1].rId);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecHome(
                                restaurant[restaurant.length - index - 1]
                                    .rId)));
                  });
                },
              ),
              Spacer(),
              SmoothStarRating(
                rating: restaurant[index].rate.toDouble(),
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
              SizedBox(
                width: 50,
              ),
            ]),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
          
drawer: Drawer(
          child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.all(8),
          color: Colors.green[500],
          child: Center(
              child: Text(
            'Restaurant App',
            style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 3,
            ),
          )),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          child: FlatButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddForm()));
              },
              icon: Icon(
                Icons.add_box,
                color: Colors.blue,
                size: 30,
              ),
              label: Text(
                'Add Restaurant',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          child: FlatButton.icon(
              onPressed: () {
                
              },
              icon: Icon(
                Icons.notifications_active,
                color: Colors.red,
                size: 30,
              ),
              label: Text(
                ' Notifications',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          child: FlatButton.icon(
              onPressed: () {
                
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.green,
                size: 30,
              ),
              label: Text(
                ' View booked \n\t Tables',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ])),
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: typing
                  ? TextField(
                      onChanged: (text) {
                        _onchangesearch(text);
                      },
                    )
                  : Text('Vendor App'),
              backgroundColor: Colors.green[400],
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    
                    onPressed: () {
                      _onchangesearch('');
                      //print(restaurant);
                      setState(() {
                        typing = !typing;
                      });
                    })
              ],
            ),
            body: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        FontAwesomeIcons.utensils,
                        size: 20,
                        color: Colors.amber[600],
                      ),
                    ),
                    Text(
                      ' The Restaurants ',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                          fontStyle: FontStyle.normal),
                    ),
                    Spacer(),
                    DropdownButton(
                      value: dropdownValue,
                      icon: Icon(Icons.list),
                      iconSize: 25,
                      elevation: 16,
                      items: <String>[
                        'Categories',
                        'Fast food',
                        'Pizza',
                        'Healthy Food',
                        'Desserts'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      onChanged: (String newValue) {
                        newValue == 'Categories'
                            ? _onchangesearch('')
                            : _onchangesearchcat(newValue);
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                    ),
                  ],
                ),

                // Visibility(
                //   visible: _visible,
                //   child: Row(children: [
                //     Expanded(
                //         child: ListView(children: <Widget>[
                //       for (k = 0; k < category.length; k++) _bBuildCard()
                //     ]))
                //   ]),
                // ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: restaurant.length,
                      itemBuilder: (BuildContext context, int index) =>
                          card(context, index)),
                ),
              ]),
            ),
          );
  }
}
