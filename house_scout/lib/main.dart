import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/house_owner/dashboard.dart';
import 'package:house_scout/house_owner/edit_property.dart';
import 'package:house_scout/house_owner/owner_navbar.dart';
import 'package:house_scout/house_owner/properties.dart';
import 'package:house_scout/login.dart';
import 'package:house_scout/profile.dart';
import 'package:house_scout/register.dart';
import 'package:house_scout/scouter/chat.dart';
import 'package:house_scout/scouter/dashboard.dart';
import 'package:house_scout/scouter/favs.dart';
import 'package:house_scout/scouter/filter.dart';
import 'package:house_scout/scouter/nearby_properties.dart';
import 'package:house_scout/scouter/owner_profile.dart';
import 'package:house_scout/scouter/payment.dart';
import 'package:house_scout/scouter/scouter_navbar.dart';
import 'package:house_scout/scouter/search_result.dart';
import 'package:house_scout/view_property.dart';
import 'package:house_scout/splash.dart';
import 'package:house_scout/usertype.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'House Scout',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/usertype', page: () => UserType()),
        GetPage(name: '/ownerNavBar', page: () => OwnerNavBar()),
        GetPage(name: '/houseOwner', page: () => Dashboard()),
        GetPage(name: '/myProperties', page: () => MyProperties()),
        GetPage(name: '/editProp', page: ()=> EditProperty()),
        GetPage(name: '/scouterNavBar', page: () => ScouterNavBar()),
        GetPage(name: '/scouter', page: () => ScouterDashboard()),
        GetPage(name: '/nearbyProperties', page: () => NearbyProperties()),
        GetPage(name: '/filter', page: () => Filter()),
        GetPage(name: '/searchResult', page: () => SearchResult()),
        GetPage(name: '/viewProperty', page: () => ViewProperty()),
        GetPage(name: '/favs', page: () => Favs()),
        GetPage(name: '/ownerProfile', page: () => OwnerProfile()),
        GetPage(name: '/payment', page: () => Payment()),
        GetPage(name: '/chat', page: () => Chat()),
        GetPage(name: '/profile', page: () => Profile())
      ],
    );
  }
}
