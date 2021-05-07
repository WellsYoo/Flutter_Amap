class PoiSearch {
  PoiSearch({
    this.cityCode,
    this.cityName,
    this.address,
    this.provinceName,
    this.title,
    this.adName,
    this.adCode,
    this.provinceCode,
    this.latitude,
    this.longitude,
  });

  PoiSearch.fromJsonMap(Map<String, dynamic> map)
      : cityCode = map['cityCode'] as String,
        cityName = map['cityName'] as String,
        address = map['address'] as String,
        provinceName = map['provinceName'] as String,
        title = map['title'] as String,
        adName = map['adName'] as String,
        adCode = map['adCode'] as String,
        provinceCode = map['provinceCode'] as String,
        latitude = map['latitude'] as String,
        longitude = map['longitude'] as String;

  String cityCode;
  String cityName;
  String address;
  String provinceName;
  String title;
  String adName;
  String adCode;
  String provinceCode;
  String latitude;
  String longitude;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cityCode'] = cityCode;
    data['cityName'] = cityName;
    data['address'] = address;
    data['provinceName'] = provinceName;
    data['title'] = title;
    data['adName'] = adName;
    data['adCode'] = adCode;
    data['provinceCode'] = provinceCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
