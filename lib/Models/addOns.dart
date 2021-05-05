class ProductAddons {
  int id;
  String name;
  double price;
  String productId;

  ProductAddons({this.id, this.name, this.price, this.productId});

  ProductAddons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price']);
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['productId'] = this.productId;
    return data;
  }
}
