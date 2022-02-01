import 'package:app/state/post_state.dart';
import 'package:app/widgets/app_drawer.dart';
import 'package:app/widgets/single_category.dart';
import 'package:app/widgets/single_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  static const routeName = '/home-screens'; 
  const HomeScreens({ Key? key }) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {

  bool _init = true; 
  bool _isLoading = false;
  @override
  void didChangeDependencies() async{
    if(_init){
      Provider.of<PostState>(context, listen: false).getCategoryData();
      _isLoading = await Provider.of<PostState>(context, listen: false).getPostData();
      setState(() {
        
      });
    }
    _init = false; 
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<PostState>(context).post;   
    final category = Provider.of<PostState>(context).category;   
    
    if(_isLoading == false || posts == null || category == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Welcome to Code"),  
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 45.0,
              child: ListView.builder(itemBuilder: (ctx, i) => SingleCategory(
                  category[i] 
                ),
              itemCount: category.length,
              scrollDirection: Axis.horizontal,),
            ),
          ),
            const Divider(),
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
}