class Product {
   String title, thumbnail, price, url;

   Product(this.title, this.thumbnail, this.price, this.url);
   factory Product.fromJson(Map<String, dynamic> json) {
     return Product(
       json['title'],
       json['thumbnail'],
       json['price'],
       json['url'],
     );
   }
}