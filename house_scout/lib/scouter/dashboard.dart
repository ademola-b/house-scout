import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:house_scout/utils/defaultText.dart';

class ScouterDashboard extends StatelessWidget {
  const ScouterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultText(text: "Scouter"),
      ),
    );
  }
}
