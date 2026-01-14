

import 'package:flutter/material.dart';

import 'package:animation_project/utils/app_color.dart';

class CategoryModel {
final String id;
final String name;
final int productsCount;
final Color bgColor;
final Color textColor;

  CategoryModel( {
    required this.id,
     required this.name,
      required this.productsCount,
       this.bgColor= AppColor.primary,
       this.textColor=AppColor.white,
      
      });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'productsCount': productsCount,
      // ignore: deprecated_member_use
      'bgColor': bgColor.value,
      // ignore: deprecated_member_use
      'textColor': textColor.value,
    };
  }

  factory CategoryModel.fromMap(
    Map<String, dynamic> map, {
    String? documentId,
  }) {
    return CategoryModel(
      id: map['id'] ?? documentId ?? "",
      name: map['name'] ??"",
      productsCount: map['productsCount']??0,
      bgColor: Color(map['bgColor'] ),
      textColor: Color(map['textColor'] ),
    );
  }

 
}

List<CategoryModel>dummyCategories=[
  CategoryModel(
    id: '1',
    name: 'New Arrivals',
    productsCount: 208,
    bgColor: AppColor.grey,
    textColor: AppColor.black,
  ),
  CategoryModel(
    id: '2',
    name: 'Clothes',
    productsCount: 358,
    bgColor: AppColor.green,
    textColor: AppColor.white,
  ),
  CategoryModel(
    id: '3',
    name: 'Bags',
    productsCount: 160,
    bgColor: AppColor.black,
    textColor: AppColor.white,
  ),
  CategoryModel(
    id: '4',
    name: 'Shoes',
    productsCount: 230,
    bgColor: AppColor.grey,
    textColor: AppColor.black
  ),
  CategoryModel(
    id: '5',
    name: 'Electronics',
    productsCount: 101,
    bgColor: AppColor.blue,
    textColor: AppColor.white
  ),


];