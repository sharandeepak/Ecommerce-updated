import 'package:ecommerce/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/constants.dart';

class ProductCard extends StatelessWidget {
  final String ProductId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;

  const ProductCard(
      {this.ProductId, this.onPressed, this.imageUrl, this.title, this.price});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(
                      productId: ProductId,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 250.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1.0,
                      blurRadius: 30.0,
                    )
                  ]),
              height: 200.0,
              width: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                // child: Shimmer.fromColors(
                //   baseColor: Colors.grey[200],
                //   highlightColor: Colors.grey[300],
                child: Image.network(
                  "${imageUrl}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: constants.regularHeading,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
