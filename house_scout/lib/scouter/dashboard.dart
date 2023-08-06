import 'package:flutter/material.dart';


class ScouterDashboard extends StatelessWidget {
  const ScouterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset("assets/images/default.jpg"),
            )
          ],
        )
      ],
    ));
  }
}
