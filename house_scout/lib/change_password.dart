import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultText.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final controller = Get.put(BtnController());

  final _form = GlobalKey<FormState>();

  late String _oldPass, _newPass, _conPass;

  TextEditingController _newP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Constants.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
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
                      text: "Change Password",
                      color: Colors.orange,
                      size: 20.0,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Form(
                    key: _form,
                    child: Column(
                      children: [
                        Obx(() => DefaultTextFormField(
                              obscureText: controller.passwordHidden.value,
                              label: "Old Password",
                              icon: Icons.lock,
                              maxLines: 1,
                              validator: Constants.validator,
                              onSaved: (newValue) => _oldPass = newValue!,
                              suffixIcon: GestureDetector(
                                onTap: () => controller.passwordHidden.value =
                                    !controller.passwordHidden.value,
                                child: Icon(controller.passwordHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            )),
                        const SizedBox(height: 20.0),
                        Obx(() => DefaultTextFormField(
                              obscureText: controller.passwordHidden.value,
                              label: "New Password",
                              icon: Icons.lock,
                              maxLines: 1,
                              validator: Constants.validator,
                              onSaved: (newValue) => _newPass = newValue!,
                              suffixIcon: GestureDetector(
                                onTap: () => controller.passwordHidden.value =
                                    !controller.passwordHidden.value,
                                child: Icon(controller.passwordHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            )),
                        const SizedBox(height: 20.0),
                        Obx(() => DefaultTextFormField(
                              obscureText: controller.passwordHidden.value,
                              label: "Confirm Password",
                              icon: Icons.lock,
                              maxLines: 1,
                              validator: Constants.validator,
                              onSaved: (newValue) => _conPass = newValue!,
                              suffixIcon: GestureDetector(
                                onTap: () => controller.passwordHidden.value =
                                    !controller.passwordHidden.value,
                                child: Icon(controller.passwordHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            )),
                        const SizedBox(height: 70.0),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Obx(() => DefaultButton(
                                  onPressed: () {
                                    // controller.isClicked.value = true;
                                  },
                                  textSize: 18,
                                  child: controller.circ("Change Password"),
                                  // text: "Login",
                                )))
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
