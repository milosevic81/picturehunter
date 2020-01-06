class QuestionData {
  String id;
  int order;
  String title;
  String image;
  String thumb;
  List<String> solutions;

  QuestionData(
      {this.id,
        this.order,
        this.title,
        this.image,
        this.thumb,
        this.solutions});

  QuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order'];
    title = json['title'];
    image = json['image'];
    thumb = json['thumb'];
    solutions = json['solutions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order'] = this.order;
    data['title'] = this.title;
    data['image'] = this.image;
    data['thumb'] = this.thumb;
    data['solutions'] = this.solutions;
    return data;
  }
}