import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../abstracts/abstracts.dart';
import '../../models/post_model/post_model.dart';

class MyDatabase implements workingDatabase{
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'newsApp.db');

    _database = await openDatabase(path, version: 1, onCreate: (db, version){
      return db.execute("CREATE TABLE posts("
          'id INTEGER NOT NULL PRIMARY KEY,'
          'postId INTEGER NOT NULL,'
          'type TEXT NOT NULL,'
          'slug TEXT NOT NULL,'
          'url TEXT NOT NULL,'
          'status TEXT NOT NULL,'
          'title TEXT NOT NULL,'
          'title_plain TEXT NOT NULL,'
          'content TEXT NOT NULL,'
          'excerpt TEXT NOT NULL,'
          'date TEXT NOT NULL,'
          'modified TEXT NOT NULL,'
          'categories TEXT NOT NULL'
          ")");
    },);
    print('database: ${path}');
    return database;
  }

  Future<bool> insertPosts(List<PostModel> posts) async{
    final db = await database;
    for(var post in posts) {
      List<Map> result = await db.query('posts', where: 'postID = ?', whereArgs: [post.id], columns: ['COUNT(type)']);

      if(result[0]['COUNT(type)']==0)
      db.insert('posts',post.toMap());
    }
    return true;
  }

  Future<List<PostModel>> readPostFromDb() async{
    final db = await database;
    List<PostModel> posts = [];
    List<Map<String, dynamic>> results = await db.query('posts', orderBy: 'id DESC');

    for(var result in results){
      posts.add(PostModel.fromJson(result));
    }

    return posts;
  }
}
