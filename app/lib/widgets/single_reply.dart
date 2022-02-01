import 'package:app/model/post_model.dart';
import 'package:flutter/material.dart';

class SingleReply extends StatelessWidget {
   final Reply reply;
  const SingleReply(this.reply);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("By ${reply.user!.username.toString()} on ${reply.time.toString()}", style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),),
              Text(reply.title.toString(), style: const TextStyle(
                fontSize: 16.0,
              ),),
            ],
          ),
        )
      ),
    );
  }
}