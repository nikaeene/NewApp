import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:newapp/constants/Constants.dart';
import 'package:newapp/models/json_model/json_model.dart';
import 'package:newapp/sevices/database/create_database.dart';

import '../../../abstracts/abstracts.dart';
import '../../../models/post_model/post_model.dart';

class FetchPosts implements FetchPost{

  //try to get a result from API, pars it and get list of posts out.
  Future<List<PostModel>> getPosts() async{
    List<PostModel> postsList = [];

    try{
      //making a uri to call the API, you can use http OR https
      Uri uri = Uri.http(Constants.newsUrl, Constants.newnUncodedPath);
      http.Response response = await http.get(uri);
      //check if the response is ok.
      if(response.statusCode==200){
        //1. decode the response body, 2.parse the response body to get JsonModel
        JsonModel json = JsonModel.fromJson(jsonDecode(response.body));
        for(var post in json.posts){
          //try to make a Postmodel and then add it to a list.
          PostModel singlePost = PostModel.fromJson(post);
          postsList.add(singlePost);
        }
      }
    }catch(e){
      rethrow;
    }
    return postsList;
  }
}