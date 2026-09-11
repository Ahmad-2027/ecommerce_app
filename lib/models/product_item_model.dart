import 'package:ecommerce_app/utitlities/app_assets.dart';

class ProductItemModel {
  final String id;
  final String name;
  final String imgUrl;
  final double price;
  String description;
  final String category;
  bool isFavorite;
  ProductItemModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.description = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    required this.price,
    this.isFavorite = false,
    required this.category,
  });
}

List<ProductItemModel> dummyProducts = [
  ProductItemModel(
    id: 'K434118okA3XH70vmCgI',
    name: 'Black Shoes',
    imgUrl: AppAssets.menShoesImage,
    price: 20,
    category: 'Shoes',
    isFavorite: true
  ),
  ProductItemModel(
    id: '3p6nOiAbCwlKNZkme7t2',
    name: 'Trousers',
    imgUrl:AppAssets.trouserImage,
    price: 30,
    category: 'Clothes',
    isFavorite: true
  ),
  ProductItemModel(
    id: 'Y4xM7ukLvqRsurgioQmN',
    name: 'Pack of Tomatoes',
    imgUrl: AppAssets.tomatoImage,
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: 'OHncCKAImAwC9jg9XPam',
    name: 'Pack of Potatoes',
    imgUrl: AppAssets.potatoImages,
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: '7WqSYwiEbed0G05zM72u',
    name: 'Pack of Onions',
    imgUrl: AppAssets.onionImages,
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: 'NQwKrejnxOFcgAzdkoQm',
    name: 'Pack of Apples',
    imgUrl: AppAssets.appleImage,
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'uIVHYv1tLpiC3Jwik8b0',
    name: 'Pack of Oranges',
    imgUrl: AppAssets.orangeImages,
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'BOQKlAc0GlRZXOmzcs1l',
    name: 'Pack of Bananas',
    imgUrl: AppAssets.bananasImage,
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'atZHZfhF5glVKKO3XCtz',
    name: 'Pack of Mangoes',
    imgUrl: AppAssets.mongoImage,
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'jXDJxAUnBWJTXrOn5V1n',
    name: 'Sweet Shirt',
    imgUrl: AppAssets.tShirtImage ,
    price: 15,
    category: 'Clothes',
  ),
  ProductItemModel(
    id: 'PjORGdvg4dVIxnVjjhgB',
    name: 'T-shirt',
    imgUrl: AppAssets.tShirtImage,
    price: 10,
    category: 'Clothes',
  ),
];
