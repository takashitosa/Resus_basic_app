import 'package:resus_basic_app/city/city_type.dart';

class City {
  City({
    required this.prefCode,
    required this.cityCode,
    required this.cityName,
    required this.cityType,
  });

  // JSONを引数に取り、中身をそれぞれ展開しCityクラスに変換して返却する
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      prefCode: json['prefCode'] as int,
      cityCode: json['cityCode'] as String,
      cityName: json['cityName'] as String,
      cityType: CityType.values[int.parse(json['bigCityFlag'] as String)],
    );
  }
  int prefCode;
  String cityCode;
  String cityName;
  CityType cityType;

  // ref. https://dart.dev/languege/operators
  @override
  bool operator == (Object other) {
    return other is City &&
    other.prefCode == prefCode &&
    other.cityCode == cityCode &&
    other.cityName == cityName &&
    other.cityType == cityType;
  }

  @override
  int get hashCode;
}
