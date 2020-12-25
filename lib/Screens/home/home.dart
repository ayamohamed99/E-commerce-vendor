import 'package:ecommerce/Components/loading.dart';
import 'package:ecommerce/Models/categoryDetail.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/Screens/home/addform.dart';
import 'package:ecommerce/Screens/sechome.dart';
import 'package:ecommerce/Services/category.Services.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final AuthService _auth = AuthService();

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

  bool _visible = false;

  List<RestaurantDetail> restaurant;
  List<RestaurantDetail> resSort;

  RestaurantService resServ = new RestaurantService();

  // ignore: missing_return

  // ignore: missing_return
  Future<List<RestaurantDetail>> _fechRestaurantData() async {
    restaurant = await resServ.fetchData();
    resSort = await resServ.fetchData();
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
              child: Image.asset(
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
                  style: TextStyle(fontSize: 25),
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
    if (restaurant == null) return Loading();
    return Scaffold(
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
        title: Text('Vendor App'),
        backgroundColor: Colors.green[400],
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
              FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      _visible = !_visible;
                    });
                  },
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  ),
                  label: Text(
                    'Categories',
                    style: TextStyle(fontSize: 20),
                  )),
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
