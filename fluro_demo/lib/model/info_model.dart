class InfoModel {
  String? name;
  int? age;
  bool? sex;

  InfoModel({this.age, this.name, this.sex});

  @override
  String toString() {
    return "userName:$name,age:$age,sex:$sex";
  }
}
