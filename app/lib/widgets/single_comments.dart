import 'package:app/model/post_model.dart';
import 'package:app/state/post_state.dart';
import 'package:app/widgets/single_reply.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleComment extends StatefulWidget {
  final Comment comment;
  const SingleComment(this.comment);

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {
  bool _showReply = false;
  String replyText = '';
  final replyController = TextEditingController();

  void _addReply(){
    if(replyText.isEmpty){
      return;
    }

    Provider.of<PostState>(context, listen: false).addReply(widget.comment.id!, replyText);
    replyController.text = '';
    replyText = '';
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
     child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "By ${widget.comment.user!.username.toString()} at ${widget.comment.time}",
              style: const TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
              
            ),
            Container(
                margin: const EdgeInsets.only(left: 10.0),
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.comment.title.toString(),
                  style: const TextStyle(
                  fontSize: 19.0,
                ),
              ),
            ),
            FlatButton(
              onPressed: (){
                setState(() {
                _showReply = !_showReply;                  
                });
              },
              child: Text(
                "Reply(${widget.comment.reply!.length})",
              ) ,
              ),
              if(_showReply)
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: TextField(
                        controller: replyController,
                        onChanged: (v){
                          setState(() {
                              replyText = v;                            
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Reply",
                          suffix: IconButton(
                            onPressed:  replyText.isEmpty ? null : (){
                              _addReply();
                            },
                            icon: const Icon(Icons.send),
                            color: Colors.blue,
                            ),  
                        ),
                      ),
                    ),
                    if(widget.comment.reply.toString().isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.comment.reply!.map((r) => SingleReply(r),).toList(),
                    ),
                  ],
                ),
              ), 
          ],
        ),
      ),
    );
  }
}