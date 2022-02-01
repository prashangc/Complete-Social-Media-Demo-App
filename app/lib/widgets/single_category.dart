import 'package:app/model/post_model.dart';
import 'package:app/screens/category_screens.dart';
import 'package:flutter/material.dart';

class SingleCategory extends StatelessWidget {
  final Category category;
  const SingleCategory(this.category); 
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(CategoryScreens.routeName,arguments: category.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(category.title.toString(), style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),),
          ),    
        ),
      ),
    );
  }
}