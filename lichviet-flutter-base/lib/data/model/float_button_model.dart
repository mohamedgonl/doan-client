import 'package:lichviet_flutter_base/domain/entities/float_button_entity.dart';

class FloatButtonModel implements FloatButtonEntity {
  @override
  String? show;
  @override
  String? iconImage;
  @override
  String? link;
  @override
  String? showForProUser;

  FloatButtonModel({this.show, this.iconImage, this.link, this.showForProUser,});

  FloatButtonModel.fromJson(Map<String, dynamic> json) {
    show = json['show'];
    iconImage = json['icon_image'];
    link = json['link'];
    showForProUser = json['show_for_pro_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['show'] = show;
    data['icon_image'] = iconImage;
    data['link'] = link;
    data['show_for_pro_user'] = showForProUser;
    return data;
  }
}
