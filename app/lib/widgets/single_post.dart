import 'dart:math';

import 'package:app/model/post_model.dart';
import 'package:app/screens/category_screens.dart';
import 'package:app/screens/post_details_screen.dart';
import 'package:app/state/post_state.dart';
import 'package:app/widgets/single_comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  const SinglePost(this.post);
  
  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  bool _showComments = false;
  String commentTitle =  '';
  final commentController = TextEditingController();   
  void _addComment(){
    if(commentTitle.isEmpty){
      return;
    }
    Provider.of<PostState>(context, listen: false).addComment(widget.post.id!, commentTitle);
    commentTitle =  '';
    commentController.text = '';
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent[100],
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.post.title.toString(), style: const TextStyle(
                  fontSize: 18.0,
                ),),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(CategoryScreens.routeName, arguments: widget.post.category!.id); 
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(widget.post.category!.title.toString(), style: const TextStyle(
                        fontSize: 16.0,
                      ),),
                    ),
                  ),
                ),
              ],
            ),
            if(widget.post.code!.isNotEmpty)
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
                  child: Text(widget.post.code.toString(), style: const TextStyle(
                  color: Colors.white
                  ),),
                )),
              ),
              ],
            ),
            
              widget.post.content!.length > 100
              ? Container(
                child: Column(
                  
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.post.content!.substring(0,100).toString()}..."    
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(PostDetailsScreens.routeName,arguments: widget.post.id!);
                      },
                      child: const Text(
                        "Read More", 
                        style: TextStyle(
                          color: Colors.red,
                          ),
                          ),
                    ),
                        const Divider(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: (){
                                  Provider.of<PostState>(context, listen: false).addLike(widget.post.id!); 
                                },
                                icon: Icon(
                                  widget.post.like! ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                 ),
                                 label: Text(                                  
                                   "Like(${widget.post.totallike})",
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
                                  "Comment(${widget.post.comment!.length})",
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
                                  children: widget.post.comment!.map((e) => SingleComment(e)).toList(),  
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
                  "post content: " + widget.post.content!.toString(),    
                ),
              )
           ],
        ),
      ),
    );
  }
}