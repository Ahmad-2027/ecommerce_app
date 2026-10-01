import 'package:ecommerce_app/utitlities/color_asset.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String imgUrl;
  final int productsCount;
  final Color textColor;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.imgUrl,
    this.textColor = AppColors.white,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'productsCount': productsCount,
      'textColor': textColor.toARGB32(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    final rawTextColor = map['textColor'];
    final textColorValue = rawTextColor is String
        ? int.parse(
            '${rawTextColor.replaceFirst('#', '').length == 6 ? 'FF' : ''}${rawTextColor.replaceFirst('#', '')}',
            radix: 16,
          )
        : rawTextColor as int;

    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imgUrl: map['imgUrl'] as String,
      productsCount: map['productsCount'] as int,
      textColor: Color(textColorValue),
    );
  }
}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'New Arrivals',
    productsCount: 208,
    imgUrl:
        'https://images.pexels.com/photos/33705550/pexels-photo-33705550.jpeg',
    textColor: AppColors.white,
  ),
  CategoryModel(
    id: '2',
    name: 'Clothes',
    productsCount: 358,
    textColor: AppColors.white,
    imgUrl:
        'https://images.pexels.com/photos/6461325/pexels-photo-6461325.jpeg',
  ),
  CategoryModel(
    id: '3',
    name: 'Bags',
    productsCount: 160,
    textColor: AppColors.white,
    imgUrl:
        'https://images.pexels.com/photos/6650001/pexels-photo-6650001.jpeg',
  ),
  CategoryModel(
    id: '4',
    name: 'Shoes',
    productsCount: 230,
    textColor: AppColors.white,
    imgUrl:
        'https://images.pexels.com/photos/38487263/pexels-photo-38487263.jpeg',
  ),
  CategoryModel(
    id: '5',
    name: 'Electronics',
    productsCount: 101,
    textColor: AppColors.white,
    imgUrl:
        'https://images.pexels.com/photos/18485666/pexels-photo-18485666.jpeg',
  ),
];
