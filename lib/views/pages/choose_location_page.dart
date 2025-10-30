import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/view_models/choose_location_cubit/choose_location_cubit.dart';
import 'package:animation_project/views/widgets/main_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController locationcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChooseLocationCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Adresse')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your location",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Text(
                  "Let's find an unforgatable experience near you. Choose a location below to get started",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColor.grey),
                ),
                const SizedBox(height: 36),
                TextField(
                   controller: locationcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    suffixIcon: BlocConsumer<ChooseLocationCubit, ChooseLocationState>(
                      
                      bloc: cubit,
                      listenWhen: (previous, current) => current is LocationAdded,
                      listener: (context, state) {
                        if(state is LocationAdded){
                          locationcontroller.clear();
                        }
                      },
                      buildWhen: (previous, current) => current is AddingLocation||current is LocationAdded||current is LocationAddednFailure,
                      builder: (context, state) {
                        if(state is AddingLocation){
                          return Center( 
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: AppColor.grey,
                            ),
                            
                            );
                        }
                        return IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (locationcontroller.text.isNotEmpty) {
                              cubit.addLocaton(locationcontroller.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Enter a location")),
                              );
                            }
                          },
                        );
                      },
                    ),

                    hintText: "Enter location: city-country ",
                    fillColor: AppColor.grey1,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColor.red),
                    ),
                  ),
                ),
                const SizedBox(height: 36),

                Text(
                  "Select Loaction",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                  bloc: cubit,
                  buildWhen:
                      (previous, current) =>
                          current is FetchedLocations ||
                          current is FetchLocationFailure ||
                          current is FetchingLocations,
                  builder: (context, state) {
                    if (state is FetchingLocations) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is FetchedLocations) {
                      final locations = state.locations;
                      return ListView.builder(
                        itemCount: locations.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final lacation = locations[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.grey),

                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lacation.city,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                        ),
                                        Text(
                                          "${lacation.city}, ${lacation.country}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColor.grey),
                                        ),
                                      ],
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.black,
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                          lacation.imgUrl,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is FetchLocationFailure) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                MainBotton(text: "Confrim", onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
