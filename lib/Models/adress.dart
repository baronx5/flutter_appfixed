class Adress {
  String area;
  String block;
  String floor;
  String housenumber;
  int id;
  String jada;
  String street;
  String userId;

  Adress(
      {this.area,
      this.block,
      this.floor,
      this.housenumber,
      this.id,
      this.jada,
      this.street,
      this.userId});

  Adress.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    block = json['block'];
    floor = json['floor'];
    housenumber = json['housenumber'];
    id = json['id'];
    jada = json['jada'];
    street = json['street'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['block'] = this.block;
    data['floor'] = this.floor;
    data['housenumber'] = this.housenumber;
    data['id'] = this.id;
    data['jada'] = this.jada;
    data['street'] = this.street;
    data['userId'] = this.userId;
    return data;
  }
}
