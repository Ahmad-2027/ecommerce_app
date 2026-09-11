import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/view_models/cubit/home_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/categories_tab_view.dart';
import 'package:ecommerce_app/views/pages/widgets/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          'https://images.pexels.com/photos/6634172/pexels-photo-6634172.jpeg',
                        ),
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ahmad Alwazeh",
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
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: isLandScape ? size.height * 0 : size.height * 0.02,
              ),
              TabBar(
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                tabs: [
                  Tab(text: 'Home'),
                  Tab(text: 'Category'),
                ],
              ),
              SizedBox(
                height: isLandScape ? size.height * 0.04 : size.height * 0.02,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [HomeTabView(), CategoriesTabView()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
