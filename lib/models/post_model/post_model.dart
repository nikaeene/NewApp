import 'package:equatable/equatable.dart';

class PostModel extends Equatable{
  int id;
  String type;
  String slug;
  String url;
  String status;
  String title;
  String title_plain;
  String content;
  String excerpt;
  String date;
  String modified;
  var categories;

  PostModel(
      int id,
      this.type,
      this.slug,
      this.url,
      this.status,
      this.title,
      this.title_plain,
      this.content,
      this.excerpt,
      this.date,
      this.modified,
      this.categories
      ): this.id = id,
        assert(type != null),
        assert(type != null),
        assert(slug != null),
        assert(url != null),
        assert(status != null),
        assert(title != null),
        assert(title_plain != null),
        assert(content != null),
        assert(excerpt != null),
        assert(date != null),
        assert(modified != null),
        assert(categories != null);


  factory PostModel.fromJson(Map<String, dynamic> json){
    return PostModel(json['id'], json['type'], json['slug'], json['url'], json['status'], json['title'], json['title_plain'], json['content'], json['excerpt'], json['date'], json['modified'], json['categories']);
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> myMap= {
      'postId' : this.id,
      'type' : this.type,
      'slug' : this.slug,
      'url' : this.url,
      'status' : this.status,
      'title' : this.title,
      'title_plain' : this.title_plain,
      'content' : this.content,
      'excerpt' : this.excerpt,
      'date' : this.date,
      'modified' : this.modified,
      'categories' : '${this.categories}'
    };

    return myMap;
  }

  @override
  List<Object?> get props => [this.id,
    this.type,
    this.slug,
    this.url,
    this.status,
    this.title,
    this.title_plain,
    this.content,
    this.excerpt,
    this.date,
    this.modified,
    this.categories ];
}