import 'package:flutter/material.dart';
import 'package:flcexcheck/mockproducts.dart' show mockProducts;

class ProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockProducts.length,
        itemBuilder: (context, int) {
        return new ProductCard(mockProducts[int]);
        }
    );
  }
  
}