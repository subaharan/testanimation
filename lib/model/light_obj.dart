
class LightObj {
  String _image;
  String _title;

  String get image => _image;
  String get title => _title;

  LightObj({
      String image, 
      String title}){
    _image = image;
    _title = title;
}

  LightObj.fromJson(dynamic json) {
    _image = json["Image"];
    _title = json["Title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Image"] = _image;
    map["Title"] = _title;
    return map;
  }

}