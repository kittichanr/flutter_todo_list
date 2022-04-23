class Category {
  int? id;
  String? title;
  String? image;
  int? taskAmount;

  Category(
      {required this.id,
      required this.title,
      required this.image,
      this.taskAmount = 0});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    image = json['image'];
    taskAmount = json['taskAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['image'] = this.image;
    data['taskAmount'] = this.taskAmount;
    return data;
  }
}
