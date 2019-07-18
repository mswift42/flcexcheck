import 'package:flutter/material.dart';
import 'package:flcexcheck/product.dart' show Product;
import 'package:url_launcher/url_launcher.dart';

class ProductsWidget extends StatelessWidget {
  final List<Product> products;

  ProductsWidget(this.products);

  @override
  Widget build(BuildContext context) {
    if (products.length == 0) {
      return Container(
        child: Center(
          child: Text("No results found :("),
        ),
      );
    }
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
    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: Container(
        margin: EdgeInsets.all(2.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  child: ProductImage(product.thumbnail),
                ),
              ),
              ListTile(
                title: Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
                subtitle: Text(
                  (product.price == null)
                      ? "0"
                      : product.price.toStringAsFixed(
                          product.price.truncateToDouble() == product.price
                              ? 0
                              : 2),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageurl;

  ProductImage(this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageurl,
      fit: BoxFit.contain,
      height: 600.00,
    );
  }
}

_launchUrl(String url) async {
  await launch(url);
}
