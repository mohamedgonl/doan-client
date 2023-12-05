import 'package:lichviet_flutter_base/domain/entities/item_entity.dart';

class ItemModel implements ItemEntity {
  @override
  String? icon;

  @override
  String? link;

  @override
  String? title;

  ItemModel({this.icon, this.link, this.title});

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        icon: json['icon'],
        title: json['title'],
        link: json['link'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    data['link'] = link;
    return data;
  }
}
