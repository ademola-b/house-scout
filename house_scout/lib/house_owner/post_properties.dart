import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/defaultText.dart';

class PostProperty extends StatelessWidget {
  const PostProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultText(text: "Post Property"),
      ),
    );
  }
}
