class JsonModel{
  String status;
  int count;
  int count_total;
  int pages;
  List posts;

  JsonModel(
      this.status,
      this.count,
      this.count_total,
      this.pages,
      this.posts
      );

  factory JsonModel.fromJson(Map<String, dynamic> json){
    return JsonModel(json['status'], json['count'], json['count_total'], json['pages'], json['posts']);
  }
}