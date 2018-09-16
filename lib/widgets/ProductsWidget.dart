import 'package:flutter/material.dart';
import 'package:flcexcheck/product.dart' show Product;
import 'package:url_launcher/url_launcher.dart';

class ProductsWidget extends StatelessWidget {
  final List<Product> products;
  ProductsWidget(this.products);

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 320.0,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
        children: products.map((i) => ProductCard(i)).toList());
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
        child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(product.title),
            subtitle: Text(product.price),
          ),
          Expanded(
            child: ProductImage(product.thumbnail, product.url),
          ),
        ],
      ),
    ));
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
      child: Image.network(
        imageurl,
        fit: BoxFit.cover,
        height: 180.00,
        width: 300.00,
      ),
    );
  }
}

_launchUrl(String url) async {
  await launch(url);
}
