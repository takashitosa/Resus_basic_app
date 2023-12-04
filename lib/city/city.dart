class City {
  City({
    required this.prefCode,
    required this.cityCode,
    required this.cityName,
    required this.bigCityFlag,
  });

  // JSONを引数に取り、中身をそれぞれ展開しCityクラスに変換して返却する
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      prefCode: json['prefCode'] as int,
      cityCode: json['cityCode'] as String,
      cityName: json['cityName'] as String,
      bigCityFlag: json['bigCityFlag'] as String,
    );
  }
  int prefCode;
  String cityCode;
  String cityName;
  String bigCityFlag;
}