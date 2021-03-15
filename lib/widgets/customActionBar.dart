import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/cart_page.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasbgColor;
  CustomActionBar(
      {this.title, this.hasBackArrow, this.hasTitle, this.hasbgColor});
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("users");

  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasbgColor = hasbgColor ?? false;
    return Container(
      decoration: BoxDecoration(
        color: _hasbgColor ? Colors.red[200] : Colors.transparent,

        // gradient: LinearGradient(
        //   colors: [
        //     Colors.white,
        //     Colors.white.withOpacity(0)
        //   ],
        //   begin: Alignment(0,0),
        //   end: Alignment(0,1.3)
        // )
      ),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(
                    'assets/images/back_arrow.png',
                  ),
                  color: Colors.white,
                  width: 16.0,
                  height: 16.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title,
              style: constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: StreamBuilder(
                  stream: _userRef
                      .doc(_firebaseServices.getUserId())
                      .collection("Cart")
                      .snapshots(),
                  builder: (context, snapshot) {
                    int _totalItems = 1;
                    if (snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data.docs;
                      _totalItems = _documents.length;
                    }
                    return Text(
                      "$_totalItems" ?? "1",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
