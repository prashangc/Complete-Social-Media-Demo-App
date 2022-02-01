import 'dart:convert';

import 'package:app/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class PostState with ChangeNotifier{

  late List<Post> _posts;
  late List<Category> _category;

  LocalStorage storage = LocalStorage("usertoken");

  Future<bool> getPostData() async {
    try{
      var token = storage.getItem('token');
      String url = 'http://10.0.2.2:8000/api/posts/';
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'token $token'
      });
      var data = json.decode(response.body) as List;
      List<Post> temp = [];
      for (var element in data) {
        Post post = Post.fromJson(element);
        temp.add(post);
      }
      _posts = temp;
      notifyListeners();
      return true;
    }
    catch(e){
      print("error getPostData");
      print(e);  
      return false;
    }
  }


  Future<void> getCategoryData() async {
    try{
      var token = storage.getItem('token');
      String url = 'http://10.0.2.2:8000/api/categorys/';
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'token $token'
      });
      var data = json.decode(response.body) as List;
      print(data);
      List<Category> temp = [];
      for (var element in data) {
        Category category = Category.fromJson(element);
        temp.add(category);
      }
      _category = temp;
      notifyListeners();
    }
    catch(e){
      print("error getCategoryData");
      print(e);  
    }
  }

  Future<void> addLike(int id) async {
    try{
      var token = storage.getItem('token');
      String url = 'http://10.0.2.2:8000/api/addlike/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
          },
        body: json.encode({
          "id": id,
        }),
      );
      print(response.body);
      var data = json.decode(response.body);
      if(data['error']==false){
        getPostData();
      }
    }
    catch(e){
      print("error addLike");
      print(e);  
    }
  }

   Future<void> addComment(int postid, String commenttext) async {
    try{
      var token = storage.getItem('token');
      String url = 'http://10.0.2.2:8000/api/addComment/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
          },
        body: json.encode({
          "postid": postid,
          "comment": commenttext,
        }),
      );
      print(response.body);
      var data = json.decode(response.body);
      if(data['error']==false){
        getPostData();
      }
    }
    catch(e){
      print("error addComment");
      print(e);  
    }
  }


   Future<void> addReply(int commentid, String replytext) async {
    try{
      var token = storage.getItem('token');
      String url = 'http://10.0.2.2:8000/api/addReply/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
          },
        body: json.encode({
          "replytext": replytext,
          "commentid": commentid,
        }),
      );
      print(response.body);
      var data = json.decode(response.body);
      if(data['error']==false){
        getPostData();
      }
    }
    catch(e){
      print("error replytext");
      print(e);  
    }
  }

  Future<bool> loginNow(String username, String password) async{
      try{
        // var token = '19680d59113a08ebcf84c2bbb68159e45f1e29b8';
        String url = 'http://10.0.2.2:8000/api/login/';
        http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          },
        body: json.encode({
          "username": username,
          "password": password,
        }),
        );
      var data = json.decode(response.body) as Map;
      // print(data);
      if(data.containsKey('token')){
        // print(data['token']);
        storage.setItem('token', data['token']);
        // print(storage.getItem('token'));
        return false;
      }
      return true;
      }catch(e){
        print("error Login");
        print(e);
        return true;
      }
  }

   Future<bool> registerNow(String username, String password) async{
      try{
        String url = 'http://10.0.2.2:8000/api/register/';
        http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          },
        body: json.encode({
          "username": username,
          "password": password,
        }),
        );
      var data = json.decode(response.body) as Map;
      // if(data['error']=false){
      //   return false;
      // }
      return data['error'];
      }catch(e){
        print("error register");
        print(e);
        return true;
      }
  }

  List<Post>? get post{
    return [..._posts];
  }

  
  List<Category>? get category{
    return [..._category];
  } 

  Post singlePost(int id){
    return _posts.firstWhere((element) => element.id == id);  
  }

   List<Post> categoryPosts(int id){
    return _posts.where((element) => element.category!.id == id).toList();
  }
}