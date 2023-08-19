import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:house_scout/main.dart';
import 'package:house_scout/utils/defaultText.dart';

class More extends StatelessWidget {
  More({super.key});

  final List<String> _labels = [
    "Profile",
    "Customer Support",
    "About Us",
    "Terms & Conditions",
    "Change Password",
  ];

  final List<IconData> _labelIcons = [
    Icons.person_pin,
    Icons.crisis_alert_outlined,
    Icons.info_outline,
    Icons.security,
    Icons.lock
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  const DefaultText(
                    text: "Settings",
                    color: Colors.orange,
                    size: 20.0,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _labels.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.orange, width: 1.0)),
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(_labelIcons[index], color: Colors.orange),
                      title: DefaultText(text: _labels[index]),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.red),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: ListTile(
                  textColor: Colors.red,
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const DefaultText(size: 15.0, text: "Logout"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    sharedPreferences.clear();
                    Get.offAllNamed('/login');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
