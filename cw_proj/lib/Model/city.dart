class City{
  String name;

  City({
    this.name
  });

  factory City.formJson(Map<String, dynamic> json){
    return City(name: json['name']);
  }
}