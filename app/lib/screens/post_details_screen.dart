import 'package:app/state/post_state.dart';
import 'package:app/widgets/single_comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailsScreens extends StatefulWidget {
  static const routeName = '/post-details-screen';

  @override
  _PostDetailsScreensState createState() => _PostDetailsScreensState();
}

class _PostDetailsScreensState extends State<PostDetailsScreens> {  
  @override
  bool _showComments = false;
  String commentTitle =  '';
  final commentController = TextEditingController();   
  void _addComment(){
    if(commentTitle.isEmpty){
      return;
    }
   final id = ModalRoute.of(context)?.settings.arguments;
    Provider.of<PostState>(context, listen: false).addComment(int.parse(id.toString()), commentTitle);
    commentTitle =  '';
    commentController.text = '';
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
  final id = ModalRoute.of(context)?.settings.arguments;
  final post = Provider.of<PostState>(context).singlePost(int.parse(id.toString()));
   return Scaffold(
      appBar: AppBar(
        title: Text(post.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(post.title.toString(), style: const TextStyle(
                      fontSize: 18.0,
                    ),),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(post.category!.title.toString(), style: const TextStyle(
                          fontSize: 16.0,
                        ),),
                      ),
                    ),
                  ],
                ),
                if(post.code!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Code: ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: 
                    Card(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                      padding: const EdgeInsets.all(8.0), 
                      child: Text(post.code.toString(), style: const TextStyle(
                      color: Colors.white
                     ),),
                    )),
                  ),
                  ],
                ),
                
                  post.content!.length > 100
                  ? Container(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.content!.toString()   
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        
                            const Divider(),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: (){
                                      Provider.of<PostState>(context, listen: false).addLike(post.id!); 
                                    },
                                    icon: Icon(
                                      post.like! ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.red,
                                     ),
                                     label: Text(                                  
                                       "Like(${post.totallike})",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                           fontSize: 17,
                                     ),
                                     ),
                                     ),
                                      ElevatedButton.icon(
                                    onPressed: (){
                                      setState(() {
                                      _showComments =! _showComments;                                    
                                      });
                                    },
                                    icon: const Icon(                                   
                                      Icons.comment,
                                      color: Colors.red,
                                      ),
                                    label: Text(
                                      "Comment(${post.comment!.length})",
                                       style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                     ),
                                     ),
                                     ),
                                ],
                              ),
                            ),
                            if(_showComments)
                            Column(
                              children: [
                                Container(
                                  child: TextField(
                                    controller: commentController,
                                    onChanged: (v){
                                      setState(() {
                                        commentTitle = v;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Comment....",
                                      suffix: IconButton(
                                        onPressed:  commentTitle.isEmpty ? null : (){
                                          _addComment();
                                        },
                                         icon: const Icon(Icons.send),
                                         color: Colors.blue,
                                         ), 
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Card(
                                    child: Column(
                                      children: post.comment!.map((e) => SingleComment(e)).toList(),  
                                    ),
                                  ),
                                )
                              ],
                            )
        
                      ],
                    ),
                  )
                  :  Container(
                    child: Text(
                      "post content: " + post.content!.toString(),    
                    ),
                  )
               ],
            ),
          ),
            ),
      ),
      
    );
  }
 }