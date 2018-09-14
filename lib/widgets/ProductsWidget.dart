import 'package:flutter/material.dart';
import 'package:flcexcheck/product.dart' show Product;

class ProductsWidget extends StatelessWidget {
  final List<Product> products;
  ProductsWidget(this.products);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
        itemBuilder: (context, int) {
        return new ProductCard(products[int]);
        }
    );
  }
  
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return new Text(product.title);
  }
}