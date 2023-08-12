import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/dashboard_controller.dart';
import 'package:house_scout/utils/defaultText.dart';

class Chat extends StatelessWidget {
  Chat({super.key});

  var controller = List.generate(4, (index) => DashboardController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              "assets/images/chat.svg",
              width: 150,
              height: 150,
            ),
            DefaultText(
              text: "Chat Coming Soon",
              color: Colors.grey[900],
              size: 25,
            )
          ]),
        ),
      ),
    );
  }
}
