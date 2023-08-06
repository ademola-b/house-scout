import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/services/remote_services.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultText.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final controller = Get.put(LoginController());

  final _form = GlobalKey<FormState>();
  late final String _username, _email, _password, _confirmPassword;
  final TextEditingController _pass = TextEditingController();

  _register() async {
    // print("password: {$_password}");
    var isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();
      print("passwordAfter: {$_password}");
      Get.toNamed('/usertype', arguments: {
        'username': _username,
        'email': _email,
        'password': _password
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DefaultText(
                      text: "Create an account",
                      color: Constants.primaryColor,
                      size: 25),
                  const SizedBox(height: 30),
                  Form(
                      key: _form,
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            obscureText: false,
                            label: "Username",
                            icon: Icons.person,
                            validator: Constants.validator,
                            onSaved: (newValue) => _username = newValue!,
                            keyboardInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),
                          DefaultTextFormField(
                            obscureText: false,
                            label: "Email",
                            icon: Icons.email,
                            validator: Constants.validator,
                            onSaved: (newValue) => _email = newValue!,
                            keyboardInputType: TextInputType.text,
                            // maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          Obx(() => DefaultTextFormField(
                                text: _pass,
                                obscureText: controller.passwordHidden.value,
                                label: "Password",
                                icon: Icons.lock,
                                maxLines: 1,
                                validator: Constants.validator,
                                onSaved: (newValue) {
                                  _password = newValue!;
                                  print(_password);
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () => controller.passwordHidden.value =
                                      !controller.passwordHidden.value,
                                  child: Icon(controller.passwordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              )),
                          const SizedBox(height: 20),
                          Obx(() => DefaultTextFormField(
                                obscureText: controller.passwordHidden.value,
                                label: "Confirm Password",
                                icon: Icons.lock,
                                maxLines: 1,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "This Field is required";
                                  }
                                  if (value != _pass.text) {
                                    return "Password not Match";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) =>
                                    _confirmPassword = newValue!,
                                suffixIcon: GestureDetector(
                                  onTap: () => controller.passwordHidden.value =
                                      !controller.passwordHidden.value,
                                  child: Icon(controller.passwordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              )),
                          const SizedBox(height: 40),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: DefaultButton(
                                  onPressed: () {
                                    _register();
                                  },
                                  text: "Register",
                                  textSize: 18.0))
                        ],
                      )),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => Get.offNamed('/login'),
                    child: RichText(
                        text: const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.black87,
                                fontSize: 20),
                            children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
