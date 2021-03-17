
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  
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
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}




