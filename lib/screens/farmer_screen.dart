import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/product_page.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/customActionBar.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/constants.dart';

class FarmerScreen extends StatefulWidget {
  @override
  _FarmerScreenState createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final SnackBar _snackBar =
        SnackBar(content: Text("Product has been confirmed"));
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef
                .doc(_firebaseServices.getUserId())
                .collection("Cart")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              //Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                //Display the data in a list view

                return ListView(
                  padding: EdgeInsets.only(top: 100.0),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        productId: document.id,
                                      )));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productRef
                              .doc(document.id)
                              .get(),
                          builder: (context, productSnap) {
                            if (productSnap.hasError) {
                              return Container(
                                child: Center(
                                  child: Text("${productSnap.error}"),
                                ),
                              );
                            }
                            if (productSnap.connectionState ==
                                ConnectionState.done) {
                              Map _productMap = productSnap.data.data();
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          "${_productMap['images'][0]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 16.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_productMap['name']}",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text(
                                              "${_productMap['price']}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text(
                                            "Quantity - ${document.data()['quantity']}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Location - NuTech Flats,\nAshok Nagar,chennai",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          
                                          MaterialButton(
                                            onPressed: () {
                                              _firebaseServices.userRef
                                                  .doc(_firebaseServices
                                                      .getUserId())
                                                  .collection("Cart")
                                                  .doc(document.id)
                                                  .delete();

                                              Scaffold.of(context)
                                                  .showSnackBar(_snackBar);
                                              Future.delayed(
                                                  Duration(seconds: 1), () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FarmerScreen()));
                                              });
                                            },
                                            child: Text(
                                              "  Place Order  ",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                  backgroundColor:
                                                      Colors.amber[200]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container(
                                child: Center(
                              child: CircularProgressIndicator(),
                            ));
                          },
                        ));
                  }).toList(),
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackArrow: true,
            title: "Orders",
          )
        ],
      ),
    );
  }
}
