

class JsonData {
  final String name;
  final String designation;
  final String title;

  JsonData._({this.name, this.designation,this.title});

  factory JsonData.fromJson(Map<String, dynamic> json) {
    return new JsonData._(
      name: json['name'],
      designation: json['designation'],
      title: json['title'],
    );
  }
  JsonData.fromMappedJson(Map<String, dynamic> json)
      : name = json['name'],
        designation = json['designation'],
        title=json['title'];


  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'designation': designation,
        'title':title
      };
}