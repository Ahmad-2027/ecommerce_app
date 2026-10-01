import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/utitlities/color_asset.dart';
import 'package:ecommerce_app/views/pages/cart_page.dart';
import 'package:ecommerce_app/views/pages/favorites_page.dart';
import 'package:ecommerce_app/views/pages/home_page.dart';
import 'package:ecommerce_app/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavBar extends StatefulWidget {
  const new({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late final ScrollController _controller;
  int currentTab = 0;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              'https://images.pexels.com/photos/6634172/pexels-photo-6634172.jpeg',
            ),
            radius: 30,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ahmad alwazeh",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              "Let's Shopping",
              style: Theme.of(context).textTheme.labelMedium!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          if (currentTab == 0) ...[
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          ] else if (currentTab == 1)
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
        ],
      ),
      body: PersistentTabView(
        onTabChanged: (index) {
          setState(() {
            currentTab = index;
          });
        },
        tabs: [
          PersistentTabConfig(
            scrollController: _controller,
            screen: const HomePage(),
            item: ItemConfig(
              icon: Icon(Icons.home_outlined),
              title: "Home",
              activeForegroundColor: Theme.of(context).primaryColor,
              inactiveBackgroundColor: AppColors.grey,
            ),
          ),
          PersistentTabConfig(
            screen: const CartPage(),
            item: ItemConfig(
              icon: Icon(Icons.shopping_cart_outlined),
              title: "Orders",
              activeForegroundColor: Theme.of(context).primaryColor,
              inactiveBackgroundColor: AppColors.grey,
            ),
          ),
          PersistentTabConfig(
            screen: const FavoritesPage(),
            item: ItemConfig(
              icon: Icon(Icons.favorite_border_outlined),
              title: "Favorites",

              activeForegroundColor: Theme.of(context).primaryColor,
              inactiveBackgroundColor: AppColors.grey,
            ),
          ),
          PersistentTabConfig(
            screen: const ProfilePage(),
            item: ItemConfig(
              icon: Icon(Icons.account_circle_outlined),
              title: "Profile",

              activeForegroundColor: Theme.of(context).primaryColor,
              inactiveBackgroundColor: AppColors.grey,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style6BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
