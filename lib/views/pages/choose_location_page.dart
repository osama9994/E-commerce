import 'package:animation_project/models/location_item_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/views/widgets/main_botton.dart';
import 'package:flutter/material.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController locationcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
                    ),

                    hintText: "Enter your location ",
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
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  itemCount: dummyLacations.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder:(context, index){
                    final dummyLacation=dummyLacations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DecoratedBox(
                         decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.grey
                          ),

                          borderRadius: BorderRadius.circular(16  ),
                      
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(16.0),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dummyLacation.city,style: Theme.of(context).textTheme.titleMedium,),
                                  Text("${dummyLacation.city}, ${dummyLacation.country}",style: Theme.of(context).textTheme.titleSmall!.copyWith(color:AppColor.grey ),),
                           
                                ],
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.black,
                                      blurRadius: 8,
                                      offset: const Offset(0,4),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 50 ,
                                  backgroundImage: NetworkImage(
                                    dummyLacation.imgUrl,
                                  ),
                                ),
                              ),
                             
                            ],
                           ),
                         ),
                         ),
                    );
                  } ,
                  ),
                MainBotton(
                  text: "Confrim",
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
