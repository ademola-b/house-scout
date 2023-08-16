import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/services/remote_services.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultText.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';

class Login extends StatelessWidget {
  final controller = Get.put(BtnController());
  final _form = GlobalKey<FormState>();

  late String _username;
  late String _password;

  Login({super.key});

  _login() async {
    controller.isClicked.value = true;
    var isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState!.save();
    await RemoteServices.login(_username, _password);
    controller.isClicked.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DefaultText(
                      text: "Login to your account",
                      color: Constants.primaryColor,
                      size: 25),
                  const SizedBox(height: 30),
                  Form(
                      key: _form,
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            obscureText: false,
                            label: "Email or Username",
                            icon: Icons.person,
                            validator: Constants.validator,
                            onSaved: (newValue) => _username = newValue!,
                            keyboardInputType: TextInputType.text,
                            // maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          Obx(() => DefaultTextFormField(
                                obscureText: controller.passwordHidden.value,
                                label: "Password",
                                icon: Icons.lock,
                                maxLines: 1,
                                validator: Constants.validator,
                                onSaved: (newValue) => _password = newValue!,
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
                              child: Obx(() => DefaultButton(
                                    onPressed: () {
                                      _login();
                                      // controller.isClicked.value = true;
                                    },
                                    textSize: 18,
                                    child: controller.circ("Login"),
                                    // text: "Login",
                                  )))
                        ],
                      )),
                  const SizedBox(height: 20),
                  RichText(
                      text: const TextSpan(
                          text: "-",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          children: [
                        TextSpan(
                          text: " Or Login with",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: " -",
                          style: TextStyle(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: Constants.primaryColor)),
                    child: InkWell(
                      child: SvgPicture.asset(
                        "assets/images/google.svg",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => Get.toNamed('/register'),
                    child: RichText(
                        text: const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.black87,
                                fontSize: 20),
                            children: [
                          TextSpan(
                            text: "Sign Up",
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
