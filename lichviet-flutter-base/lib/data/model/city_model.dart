class CityModel {
  int? id;
  String? name;
  String? cityName;
  bool? isCheck = false;
  bool? isMainCity = false;
  CityModel({required this.id, required this.name, required this.cityName});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    cityName = json["cityName"];
    isCheck = json["isCheck"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["cityName"] = cityName;
    data["isCheck"] = isCheck;
    return data;
  }
}