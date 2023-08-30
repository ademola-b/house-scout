import 'package:flutter/material.dart';

import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultText.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: Colors.orange,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DefaultText(
                        text: "My Profile", color: Colors.white, size: 30.0),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_note_sharp,
                          size: 40,
                          color: Colors.white,
                        )),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(color: Colors.white, width: 5.0),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/default.jpg",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const DefaultText(
                    text: "Faisol Ademola", size: 20.0, color: Colors.white),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Full Name',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_add_alt_1),
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Gender',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        labelText: 'Location',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            // const ListTile(
            //   leading: Icon(Icons.person_pin),
            //   title: DefaultText(text: "Name"),
            //   subtitle: DefaultText(
            //     text: "Faisol Ademola",
            //     size: 18.0,
            //     color: Constants.primaryColor,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
