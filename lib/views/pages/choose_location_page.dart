import 'package:ecommerce_app/utitlities/color_asset.dart';
import 'package:ecommerce_app/view_models/location_cubit/location_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/location_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLocationPage extends StatelessWidget {
  new({super.key});
  final TextEditingController _loactionController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final locationCubit = BlocProvider.of<LocationCubit>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Address") /* leading: IconButton(onPressed: (){}, icon: Icon(Icons.chevron_left_rounded)) */,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your location",
                  style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight(600)),
                ),
                const SizedBox(height: 12),
                Text(
                  "Let's find an unforgettable event. Choose a location below to get started:",
                  style: Theme.of(context).textTheme.labelLarge!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 32),
                BlocConsumer<LocationCubit, LocationState>(
                  listener: (context, state) async{
                    if (state is AddedLocation) {
                    
                      _loactionController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Added location successfuly"),
                        ),
                      );
                    }
                  },
                  listenWhen: (previous, current) =>
                      current is AddedLocation,
                  bloc: locationCubit,
                  buildWhen: (previous, current) =>
                      current is AddedLocation ||
                      current is AddingLocation ||
                      current is AddingLocationError,
                  builder: (context, state) {
                    if (state is AddingLocation) {
                      return TextField(
                        controller: _loactionController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          prefixIconColor: AppColors.grey,
                                
                          suffixIcon: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child:
                                  const CircularProgressIndicator.adaptive(),
                            ),
                          ),
                          suffixIconColor: AppColors.grey,
                          hintText: "Write location : City,Country",
                          fillColor: AppColors.grey1,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      );
                    }
                    return Form(
                      key: _keyForm,
                      child: TextFormField(
                        validator: (value) {
                          return value == null || value.isEmpty
                              ? "Please enter location"
                              : null;
                        },
                        controller: _loactionController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          prefixIconColor: AppColors.grey,
                                
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (_keyForm.currentState!.validate()) {
                                await locationCubit.addLocation(
                                  _loactionController.text,
                                );
                              }
                            },
                            icon: Icon(Icons.add),
                          ),
                          suffixIconColor: AppColors.grey,
                          hintText: "Write location : City,Country",
                          fillColor: AppColors.grey1,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 36),
                Text(
                  "Select location",
                  style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight(600)),
                ),
                const SizedBox(height: 16),
                BlocConsumer<LocationCubit, LocationState>(
                  listener: (context, state) {
                    if (state is LocationSelectedConfirmed) {
                      Navigator.of(context).pop(state.isChnaged);
                    }
                  },
                  listenWhen: (previous, current) =>
                      current is LocationSelectedConfirmed,
                  bloc: locationCubit,
                  buildWhen: (previous, current) =>
                      current is LocationsLoading ||
                      current is LocationsLoaded ||
                      current is LoactionsLoadingError,
                  builder: (context, state) {
                    if (state is LocationsLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is LocationsLoaded) {
                      final locations = state.locations;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          locationCubit.selectedLocationid = location.isSelected
                              ? location.id
                              : locationCubit.selectedLocationid;
                          return LocationItem(location: location);
                        },
                      );
                    } else if (state is LoactionsLoadingError) {
                      return SizedBox(
                        height: 200,
                        child: Center(child: Text(state.message)),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),

                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: BlocBuilder<LocationCubit, LocationState>(
                    bloc: locationCubit,
                    buildWhen: (previous, current) =>
                        current is LocationSelectedConfirming,
                    builder: (context, state) {
                      if (state is LocationSelectedConfirming) {
                        return ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          if (locationCubit.selectedLocationid == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Select address first")),
                            );
                          } else {
                            await locationCubit.locationSelectedConfirmed();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Confirm address",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight(600),
                                color: Colors.white,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
