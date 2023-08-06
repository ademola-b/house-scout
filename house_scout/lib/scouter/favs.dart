import 'package:flutter/material.dart';
import 'package:house_scout/utils/defaultText.dart';

class Favs extends StatelessWidget {
  const Favs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultText(text: "Favourites"),
      ),
    );
  }
}
