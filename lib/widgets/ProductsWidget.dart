import 'package:flutter/material.dart';
import 'package:flcexcheck/product.dart' show Product;
import 'package:url_launcher/url_launcher.dart';

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
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(product.title),
            subtitle: Text(product.price),
          ),
          ProductImage(product.thumbnail, product.url),
        ],
      )

    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageurl;
  final String url;

  ProductImage(this.imageurl, this.url);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child:
        Image.network(imageurl),
    );
  }
}

_launchUrl(String url) async {
    await launch(url);
}