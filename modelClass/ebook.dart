class results {

  dynamic?name;
  dynamic? cover;
  dynamic?url;
  dynamic?rating;
  bool?IsFavourite;


  results({this.name, this.cover, this.url, this.rating,
       this.IsFavourite=false});

  factory results.fromJson(Map<String, dynamic> json) {
    return results(
      name: json['name'],
      cover: json['cover'],
      url: json['url'],
      rating: json['rating'],

    );
  }
}