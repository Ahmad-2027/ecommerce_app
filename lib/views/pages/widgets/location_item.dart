import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/location_model.dart';
import 'package:ecommerce_app/view_models/location_cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationItem extends StatelessWidget {
  final LocationModel location;
  const new({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LocationCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<LocationCubit, LocationState>(
        bloc: cubit,
        buildWhen: (previous, current) => current is LocationSelectedTemporary,
        builder: (context, state) {
          if (state is LocationSelectedTemporary) {
            return InkWell(
              onTap: () {
                cubit.locationSelectedTemporaray(location.id);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: location.id == cubit.selectedLocationid
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),

                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location.city,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "${location.city} , ${location.country}",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          CircleAvatar(
                            radius: 46,
                            backgroundColor:
                                location.id == cubit.selectedLocationid
                                ? Colors.blue
                                : Colors.grey.shade300,
                          ),
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: CachedNetworkImageProvider(
                              location.imgUrl,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return InkWell(
            onTap: () {
              cubit.locationSelectedTemporaray(location.id);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: location.isSelected ? Colors.blue : Colors.grey,
                ),

                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.city,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "${location.city} , ${location.country}",
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        CircleAvatar(
                          radius: 46,
                          backgroundColor: location.isSelected
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: CachedNetworkImageProvider(
                            location.imgUrl,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
