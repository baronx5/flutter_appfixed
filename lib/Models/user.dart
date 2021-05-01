class User{
  int id;
  String name;

  User({this.id,this.name});


  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}