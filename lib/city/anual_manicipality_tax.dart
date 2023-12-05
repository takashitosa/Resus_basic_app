class AnnualMunicipalitytax{
  AnnualMunicipalitytax ({
    required this.year,
    required this.value,
  });

  factory AnnualMunicipalitytax.fromJson(Map<String, dynamic> json){
    return AnnualMunicipalitytax(
      year: json['year'] as int, 
      value: json['value'] as int,
      );
  }

  final int year;
  final int value;


}
