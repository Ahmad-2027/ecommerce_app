class HomeCarouselItemModel {
  final String id;
  final String imgUrl;
  HomeCarouselItemModel({required this.id, required this.imgUrl});

  factory HomeCarouselItemModel.fromMap(Map<String, dynamic> map) {
    return HomeCarouselItemModel(
      id: map['id'] as String,
      imgUrl: map['imgUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imgUrl': imgUrl,
    };
  }
  
}

List<HomeCarouselItemModel> dummyHomeCarouselItems = [
  HomeCarouselItemModel(
    id: 'jf385EsSP2RzdIKucgW7',
    imgUrl: 'https://images.pexels.com/photos/7620626/pexels-photo-7620626.jpeg',
  ),
   HomeCarouselItemModel(
    id: 'btgMW23JED1zRsxqdKms',
    imgUrl: 'https://images.pexels.com/photos/5926431/pexels-photo-5926431.jpeg',
  ),
  HomeCarouselItemModel(
    id: 'XjZBor795dLTO2ErQGi3',
    imgUrl: 'https://images.pexels.com/photos/34577/pexels-photo.jpg',
  ), 
  HomeCarouselItemModel(
    id: '8u3jP9mBZYVSGq7JGoc6',
    imgUrl: 'https://images.pexels.com/photos/6214471/pexels-photo-6214471.jpeg',
  ),
];
