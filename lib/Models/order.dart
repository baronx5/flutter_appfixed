class Order {
  int id;
  String name;
  double price;

  List<Order> orders = [];

  Order({this.id, this.name, this.price, this.orders});
}
