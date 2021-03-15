import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/customActionBar.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:ecommerce/widgets/product_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Delivery Address'),
            content: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 2.0,
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFf2F2F2),
                    borderRadius: BorderRadius.circular(12.0)),
                child: TextField(
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Address",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 18.0,
                      )),
                )),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text('Place Order'),
              ),
            ],
          );
        });
  }

  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedQuantity = "0Kg";
  Future _addtoCart() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"quantity": _selectedQuantity});
  }

  Future _addtoSaved() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("saved")
        .doc(widget.productId)
        .set({"quantity": _selectedQuantity});
  }

  final SnackBar _snackBar =
      SnackBar(content: Text("Product Added to the Cart"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                List productSizes = documentData['quantity'];

                //set an initial size

                _selectedQuantity = productSizes[0];
                return ListView(children: [
                  Container(
                    height: 300.0,
                    child: Image.network(
                      "${documentData['images'][0]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 24.0),
                    child: Text(
                      "${documentData['name']}",
                      style: constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 24.0),
                    child: Text(
                      "${documentData['price']}",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: Text(
                      "${documentData['desc']}",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 24.0),
                    child: Text(
                      "Select Quantity",
                      style: constants.regularDarkText,
                    ),
                  ),
                  ProductSize(
                    onSelected: (size) {
                      _selectedQuantity = size;
                    },
                    productSizes: productSizes,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _addtoSaved();
                            Scaffold.of(context).showSnackBar(_snackBar);
                          },
                          child: Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              height: 40.0,
                              width: 40.0,
                              image: AssetImage("assets/images/tab_saved.png"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              _alertDialogBuilder("nothing");
                              await _addtoCart();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              height: 60.0,
                              margin: EdgeInsets.only(
                                left: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Add To Cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]);
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
            hasTitle: false,
          )
        ],
      ),
    );
  }
}
