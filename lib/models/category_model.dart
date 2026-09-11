import 'package:ecommerce_app/utitlities/color_asset.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String imgUrl;
  final int productsCount;
  final Color bgColor;
  final Color textColor;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.imgUrl,
    this.bgColor = AppColors.primary,
    this.textColor = AppColors.white,
  });
}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'New Arrivals',
    productsCount: 208,
    bgColor: AppColors.white,
    imgUrl:
        'https://images.pexels.com/photos/33705550/pexels-photo-33705550.jpeg',
    textColor: AppColors.white,
  ),
  CategoryModel(
    id: '2',
    name: 'Clothes',
    productsCount: 358,
    bgColor: AppColors.green,
    textColor: AppColors.white,
    imgUrl:
        'https://images.pexels.com/photos/6461325/pexels-photo-6461325.jpeg',
  ),
  CategoryModel(
    id: '3',
    name: 'Bags',
    productsCount: 160,
    bgColor: AppColors.black,
    textColor: AppColors.black,
    imgUrl:
        'https://images.pexels.com/photos/6650001/pexels-photo-6650001.jpeg',
  ),
  CategoryModel(
    id: '4',
    name: 'Shoes',
    productsCount: 230,
    bgColor: AppColors.white,
    textColor: AppColors.white,
    imgUrl:
        'https://images.pexels.com/photos/38487263/pexels-photo-38487263.jpeg',
  ),
  CategoryModel(
    id: '5',
    name: 'Electronics',
    productsCount: 101,
    bgColor: AppColors.blue,
    textColor: AppColors.white,
    imgUrl:
        'https://images.pexels.com/photos/18485666/pexels-photo-18485666.jpeg',
  ),
];
