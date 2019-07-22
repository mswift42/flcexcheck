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
        maxCrossAxisExtent: 340.0,
        children: products.map((i) => ProductWidget(i)).toList());
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    final _ts = TextStyle(
      fontSize: 12.0,
      color: Colors.white,
    );
    final _prodtextline = product.title.split(',');
    final _des = _prodtextline[0];
    final _condition = (_prodtextline.length == 2) ? _prodtextline[1] : '?';
    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            ' ' + _des,
            style: _ts,
          ),
          subtitle: new _ProductBottomLine(
            product: product,
            condition: _condition,
            textstyle: _ts,
          ),
        ),
        child: ProductImage(product.thumbnail),
      ),
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
        ),
        Text(
          (product.price == null)
              ? "0"
              : product.price.toStringAsFixed(
                  product.price.truncateToDouble() == product.price ? 0 : 2),
          style: textstyle,
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
      fit: BoxFit.contain,
    );
  }
}

_launchUrl(String url) async {
  await launch(url);
}
