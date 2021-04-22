class Settings {
  String id;
  String appName;
  String appDesc;
  String appLogo;

  Settings({this.id, this.appName, this.appDesc, this.appLogo});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['appName'];
    appDesc = json['appDesc'];
    appLogo = json['appLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appName'] = this.appName;
    data['appDesc'] = this.appDesc;
    data['appLogo'] = this.appLogo;
    return data;
  }
}
