import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/screens/product_page.dart';
import 'package:ecommerce/screens/user_upload.dart';
import 'package:ecommerce/widgets/customActionBar.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  
  bool onPressed1 = true, onPressed2 = false, onPressed3 = false;
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("Products");

  get shimmer => null;

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;
    floatingActionButtonLocation:
    FloatingActionButtonLocation.startTop;

    floatingActionButton:
    FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserUpload()));
      },
      backgroundColor: Colors.green,
      child: Icon(Icons.add),
    );
    return Container(
      child: Stack(children: [
        FutureBuilder<QuerySnapshot>(
          future: _productRef.get(),
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
                  return ProductCard(
                    title: document.data()['name'],
                    imageUrl: document.data()['images'][0],
                    price: "${document.data()['price']}",
                    ProductId: document.id,
                  );
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
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 120, 10, 600),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: onPressed1 == true
                            ? Colors.orange[300]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            onPressed1 = true;
                            onPressed2 = false;
                            onPressed3 = false;
                          });
                        },
                        child: Text(
                          "Fruits",
                          style: constants.regularDarkText,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: onPressed2 == true
                            ? Colors.orange[300]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            onPressed1 = false;
                            onPressed2 = true;
                            onPressed3 = false;
                          });
                        },
                        child: Text(
                          "Vegetables",
                          style: constants.regularDarkText,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: onPressed3 == true
                            ? Colors.orange[300]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            onPressed1 = false;
                            onPressed2 = false;
                            onPressed3 = true;
                          });
                        },
                        child: Text(
                          "Value Added products",
                          style: constants.regularDarkText,
                        ))),
              ),
            ],
          ),
        ),
        CustomActionBar(
          title: 'Home',
          hasBackArrow: true,
          hasTitle: true,
          hasbgColor: true,
        ),
      ], overflow: Overflow.visible),
    );
  }
}
