import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/views/pages/cart_page.dart';
import 'package:animation_project/views/pages/favorites_page.dart';
import 'package:animation_project/views/pages/home_page.dart';
import 'package:animation_project/views/pages/profile_page.dart';
import 'package:flutter/material.dart'; 
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}
 int currentIndex=0;
class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  Widget build(BuildContext context) {
   
    // List<Widget>_buildScreen(){
    //   return[
    //  HomePage(),
    //  CartPage(),
    //  FavoritesPage(),
    //  ProfilePage(),
    //   ];
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('images/profilefoto.jpg'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "osama alshalbe",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "Let's go shooping",
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          if(currentIndex==0)...[
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          ]
            else if(currentIndex==1)
            
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
          
          
        ],
      ),
      body: PersistentTabView(
      onTabChanged:(index){
        setState(() {
          currentIndex=index;
          debugPrint("currentIndex= $currentIndex");
        });
      } ,
        stateManagement: false,

        tabs: [
          
          PersistentTabConfig(
            
            
            screen: HomePage(),
            item: ItemConfig(
              icon: Icon(Icons.home),
              title: "Home",
              activeColorSecondary:AppColor.primary ,
              inactiveBackgroundColor: AppColor.grey,
            ),
          ),
          PersistentTabConfig(
            screen: CartPage(),
            item: ItemConfig(
              icon: Icon(Icons.card_giftcard),
              title: "cart",
              activeColorSecondary: AppColor.primary,
              inactiveBackgroundColor: AppColor.grey,
            ),
          ),
          PersistentTabConfig(
            screen: FavoritesPage(),
            item: ItemConfig(
              icon: Icon(Icons.favorite),
              title: "Favorites",
              activeColorSecondary: AppColor.primary,
              inactiveBackgroundColor: AppColor.grey,
            ),
          ),
          PersistentTabConfig(
            screen: ProfilePage(),
            item: ItemConfig(
              icon: Icon(Icons.person),
              title: "Profile",
              activeColorSecondary: AppColor.primary,
              inactiveBackgroundColor: AppColor.grey,
            ),
          ),
        ],
        navBarBuilder:
            (navBarConfig) => Style6BottomNavBar(navBarConfig: navBarConfig),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
          
        ),
      ),
    );
  }
}
