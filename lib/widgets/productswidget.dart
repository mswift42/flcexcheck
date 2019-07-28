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
        maxCrossAxisExtent: 320.0,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 1.0,
        children: products.map((i) => ProductWidget(i)).toList());
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    final _ts = TextStyle(
      fontSize: 10.0,
      color: Colors.black,
    );
    final _prodtextline = product.title.split(',');
    final _des = _prodtextline[0];
    final _condition = (_prodtextline.length == 2) ? _prodtextline[1] : '?';
    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              constraints: BoxConstraints(
                maxHeight: 210.0,
              ),
              child: ProductImage(product.thumbnail)),
          Column(
            children: <Widget>[
              Text(
                _des,
                style: _ts,
                textAlign: TextAlign.left,
              ),
              _ProductBottomLine(
                product: product,
                condition: _condition,
                textstyle: _ts,
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class _ProductBottomLine extends StatelessWidget {
  const _ProductBottomLine({
    Key key,
    @required this.product,
    @required this.condition,
    @required this.textstyle,
  }) : super(key: key);

  final Product product;
  final String condition;
  final TextStyle textstyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          condition,
          style: textstyle,
          textAlign: TextAlign.left,
        ),
        Text(
          (product.price == null)
              ? "0"
              : product.price.toStringAsFixed(
                  product.price.truncateToDouble() == product.price ? 0 : 2),
          style: textstyle,
          textAlign: TextAlign.right,
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
    return FractionallySizedBox(
      heightFactor: 0.6,
      widthFactor: 1.0,
      child: Image.network(
        imageurl,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

_launchUrl(String url) async {
  await launch(url);
}
