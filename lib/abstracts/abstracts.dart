import '../models/post_model/post_model.dart';

abstract class FetchPost{
  Future<List<PostModel>> getPosts();
}