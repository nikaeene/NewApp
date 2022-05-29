import 'package:sqflite/sqflite.dart';

import '../models/post_model/post_model.dart';

abstract class FetchPost{
  Future<List<PostModel>> getPosts();
}

abstract class workingDatabase{
  Future<Database> get database;
  Future<bool> insertPosts(List<PostModel> posts);
  Future<List<PostModel>> readPostFromDb();
}