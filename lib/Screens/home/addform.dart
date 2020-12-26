import 'package:ecommerce/Components/loading.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/Screens/home/home.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  String name = '';
  String location = '';
  File img;
  String rate = '';
  String hotline = '';
  String categoryN = '';
  String catId = '';
  int rId = 0;
  String numSeats = '';
  String numTables = '';
  String headline = '';
  String description = '';
  var resImgUrl;
  bool loading = true;

  RestaurantDetail restaurant = new RestaurantDetail();

  RestaurantService resServ = new RestaurantService();
  // ignore: unused_field
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic result;

  String fileName;

  // void initState() {
  //   setState(() {

  //   });
  // }

  Future uploadFile(img) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('restaurant/${img.path}');
    StorageUploadTask uploadTask = storageReference.putFile(img);
    await uploadTask.onComplete;
    // restaurant.img = await storageReference.getDownloadURL();
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }

  Future getImage() async {
    var result = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      img = File(result.path);
      resImgUrl = uploadFile(img);
      // if(restaurant.img == null)
      // Loading();
    });
  }

// ignore: unused_element
  Widget _buildResNameField() {
    return TextFormField(
      initialValue: name,
      keyboardType: TextInputType.text,
      decoration:
          InputDecoration(labelText: 'Name', icon: Icon(Icons.text_fields)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Restaurant Name is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          name = value;
          restaurant.name = value;
        });
      },
    );
  }

  // ignore: unused_element
  Widget _buildResIdField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: rId == 0 ? "" : rId.toString(),
      decoration: InputDecoration(labelText: 'Id', icon: Icon(Icons.vpn_key)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Restaurant id is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          rId = int.parse(value);
          restaurant.rId = value;
        });
      },
    );
  }

  Widget _buildResRateField() {
    return TextFormField(
      initialValue: rate,
      decoration: InputDecoration(labelText: 'Rate', icon: Icon(Icons.star)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Rate is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          rate = value;
          restaurant.rate = int.parse(value);
        });
      },
    );
  }

  // Widget _buildResTimeResField() {

  //     //var x=timeRes.values.toList();

  //   return TextFormField(

  //    initialValue: timeRes,
  //     //initialValue:timeRes[1],
  //     keyboardType: TextInputType.number,
  //     decoration: InputDecoration(labelText: 'Time',icon: Icon(Icons.timer)),
  //     // ignore: missing_return
  //     validator: ( var value) {
  //       if (value.isEmpty) {
  //         return 'Time for Reservation is Required';
  //       }
  //     },
  //     onChanged: (value) {
  //       setState(() {
  //         timeRes = value;
  //         restaurant.timeRes = int.parse(value);
  //       });
  //     },
  //   );
  // }

  Widget _buildResLocationField() {
    return TextFormField(
      initialValue: location,
      decoration:
          InputDecoration(labelText: 'Address', icon: Icon(Icons.location_on)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          location = value;
          restaurant.location = value;
        });
      },
    );
  }

  Widget _buildReshotlineField() {
    return TextFormField(
      initialValue: hotline,
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(labelText: 'Hotline', icon: Icon(Icons.phone)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Hotline is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          hotline = value;
          restaurant.hotline = value;
        });
      },
    );
  }

  Widget _buildResheadlineField() {
    return TextFormField(
      initialValue: location,
      decoration: InputDecoration(
          labelText: 'Headline', icon: Icon(Icons.view_headline)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Headline is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          headline = value;
          restaurant.headline = value;
        });
      },
    );
  }

  Widget _buildCatIdField() {
    return TextFormField(
      initialValue: catId,
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(labelText: 'Category ID', icon: Icon(Icons.lock)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Category ID is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          catId = value;
          restaurant.catId = value;
        });
      },
    );
  }

  Widget _buildCatNameField() {
    return TextFormField(
      initialValue: categoryN,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Category Name', icon: Icon(Icons.text_format)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Category Name is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          categoryN = value;
          restaurant.categoryN = value;
        });
      },
    );
  }

  Widget _buildResnumseatsField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: numSeats,
      decoration: InputDecoration(
          labelText: 'Number of seats', icon: Icon(Icons.event_seat)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Number of seats is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          numSeats = value;
          restaurant.numSeats = int.parse(value);
        });
      },
    );
  }

  Widget _buildResnumtablesField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: numTables,
      decoration: InputDecoration(
          labelText: 'Number of tables', icon: Icon(Icons.table_chart)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Number of tables is Required';
        }
      },
      onChanged: (value) {
        setState(() {
          numTables = value;
          restaurant.numTables = int.parse(value);
        });
      },
    );
  }

  Widget _buildimageField() {
    return IconButton(
        icon: Icon(
          FontAwesomeIcons.camera,
          size: 30.0,
        ),
        onPressed: () {
          getImage();
        });
  }

  Widget _buildResDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Description', icon: Icon(Icons.description)),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is Required';
        }
      },
      onSaved: (String value) {
        description = value;
        restaurant.description = description;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // loading ? Loading():
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Add Restaurant'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildResIdField(),
                _buildResNameField(),
                _buildResLocationField(),
                _buildResheadlineField(),
                _buildResDescriptionField(),
                _buildResRateField(),
                _buildReshotlineField(),
                _buildResnumseatsField(),
                _buildResnumtablesField(),
                _buildCatNameField(),
                _buildCatIdField(),
                //_buildResTimeResField(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: _buildimageField(),
                      ),
                      Spacer(),
                      RaisedButton(
                        color: Colors.green[500],
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          setState(() async {
                            // loading = true;
                            // ignore: unused_element
                             restaurant.img = await resImgUrl;
                            // void getId() async {
                            //   restaurant.rId = result.rId;
                            //   restaurant.img = await resImgUrl;
                            // }
                            Loading();
                             resServ.addRestaurant(restaurant);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          });
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
