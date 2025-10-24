import 'package:animation_project/utils/app_color.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key,required this.cubit, required this.value, required this.productId, this.initalValue});
final int value;
final String productId;
final int? initalValue;
final dynamic cubit;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration:BoxDecoration(
        color: AppColor.grey2,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(children: [
        IconButton(onPressed: ()=>initalValue!=null? cubit.decrementCounter(productId,initalValue) :cubit.decrementCounter(productId),
         icon: Icon(Icons.remove,size: 20,),
         ),
        Text(value.toString()),  
        IconButton(
          onPressed: ()=>initalValue!=null? cubit.incrementCounter(productId,initalValue): cubit.incrementCounter(productId),
        
           icon: Icon(Icons.add),),
        ],
      ),
      ),
    );
  }
}
