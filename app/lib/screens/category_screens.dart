import 'package:app/state/post_state.dart';
import 'package:app/widgets/single_category.dart';
import 'package:app/widgets/single_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreens extends StatefulWidget {
  static const routeName = '/category-screens';
  @override
  _CategoryScreensState createState() =>  _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final posts = Provider.of<PostState>(context).categoryPosts(int.parse(id.toString())); 
    return 
      posts.isEmpty? 
      Scaffold(
        appBar: AppBar(
          title: Text('No post available for ${posts[0].category!.title}'),
        ),
        body: const Center(
          child: Text("No Post",
            style: TextStyle(
              fontSize: 30.0,
          ),)),
      )
      :
      Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text("All Post for ${posts[0].category!.title}"),  
      ),
      body: Column(
        children: [ 
            Expanded(child: ListView.builder(
              itemBuilder: (ctx,i) => SinglePost(posts[i]),
              itemCount: posts.length,
              ),
              ),
        ],
      ),
    );
  }
}