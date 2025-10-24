import 'package:animation_project/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyCategories.length,
      itemBuilder: (context,index){
        final category=dummyCategories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical:  8.0),
          child: InkWell(
            onTap: (){},
            child: DecoratedBox(
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: category.bgColor
              ),  
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:  16.0,vertical: 32),
                child: Column(
                  children: [
                Text(category.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: category.textColor,
                  fontWeight: FontWeight.w600,
                ),
                ),
                Text("${category.productsCount} Products ",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: category.textColor,
                  fontWeight: FontWeight.w600
                ),
                
                ), 
                  ],
                ),
              ),
              ),
          ),
        );


      }
      
      );
    
  }
} 