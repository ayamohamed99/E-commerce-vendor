
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  Widget card(BuildContext context, int index) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        shadowColor: Colors.green[500],
        borderOnForeground: true,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Text('Buffalo Burger ',
            style: TextStyle(
              fontSize: 20
            ), ),
            Text(' table number 2',
            style: TextStyle(
              fontSize: 20
            )),
             SizedBox(height: 20,)
          ],
        ),
      ),
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
        title: Text('Notification'),
      ),
      body: Container(
        child:ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) =>
                          card(context, index)
                          ),
                ),
        );
  }
  
}




