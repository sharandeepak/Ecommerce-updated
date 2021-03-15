import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/constants.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 45.0),
                  child: Text(
                    "Search Results",
                    style: constants.regularDarkText,
                  )),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productRef
                  .orderBy("search_string")
                  .startAt([_searchString]).endAt(
                      ["$_searchString\uf8ff"]).get(),
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
                    padding: EdgeInsets.only(top: 120.0),
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
            padding: const EdgeInsets.only(top: 45.0),
            child: customInput(
              HintText: "Search Here",
              onChanged: (value) {
                setState(() {
                  _searchString = value;
                }); 
              },
            ),
          ),
        ],
      )),
    );
  }
}
