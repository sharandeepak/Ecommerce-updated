import 'package:ecommerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class UserUpload extends StatelessWidget {
  String product_name, quantity, location;
  int price;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          customInput(
            HintText: "Product Name",
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
