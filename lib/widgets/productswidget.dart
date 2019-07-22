import 'package:flcexcheck/product.dart' show Product;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        maxCrossAxisExtent: 420.0,
        children: products.map((i) => ProductCard(i)).toList());
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    final _prodtextline = product.title.split(',');
    final _des = _prodtextline[0];
    final _condition = _prodtextline[1];
    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            _des,
            style: TextStyle(
              fontSize: 11.0,
              letterSpacing: 0.03,
            ),
          ),
          subtitle: new _productBottomLine(product: product),
        ),
        child: ProductImage(product.thumbnail),
      ),
    );
  }
}

class _productBottomLine extends StatelessWidget {
  const _productBottomLine({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text()
        Text(
          (product.price == null)
              ? "0"
              : product.price.toStringAsFixed(
                  product.price.truncateToDouble() == product.price ? 0 : 2),
          style: TextStyle(color: Colors.white),
        ),
      ],
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
      fit: BoxFit.scaleDown,
      height: 600.00,
    );
  }
}

_launchUrl(String url) async {
  await launch(url);
}
