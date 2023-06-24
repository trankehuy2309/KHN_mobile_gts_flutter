import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/auth_controller.dart';
import 'package:khn_tracking/src/views/constansts/constanst.dart';
import 'package:url_launcher/url_launcher.dart';

import 'forgot_password_page.dart';
import 'registration_page.dart';
import 'widgets/header_auth.dart';

class LoginPage extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();
  String? username = Get.find<AuthController>().userName;

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetBuilder<AuthController>(
            init: Get.find<AuthController>(),
            builder: (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: ValidatorApp.fheaderHeight,
                    child: HeaderAuth(
                        ValidatorApp.fheaderHeight,
                        true,
                        true,
                        Icons
                            .login_rounded), //let's create a common header widget
                  ),
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo_home.png'),
                          const SizedBox(height: 30.0),
                          Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                Container(
                                  child: TextFormField(
                                    initialValue: username,
                                    decoration:
                                        ThemeHelper().textInputDecoration(
                                      'username'.tr,
                                      'username-desc'.tr,
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'username-invalid'.tr;
                                      }
                                    },
                                    onSaved: (value) {
                                      controller.username = value!;
                                    },
                                  ),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                const SizedBox(height: 30.0),
                                Container(
                                  child: TextFormField(
                                    // initialValue: '082084',
                                    obscureText: controller.passwordVisible!,
                                    decoration: InputDecoration(
                                      labelText: 'password'.tr,
                                      hintText: 'password-desc'.tr,
                                      fillColor: Colors.white,
                                      filled: true,
                                      suffix: InkWell(
                                        onTap: controller.togglePasswordVisible,
                                        child: Icon(
                                          controller.passwordVisible!
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2.0)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2.0)),
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'password-err'.tr;
                                      }
                                    },
                                    onSaved: (value) {
                                      controller.password = value!;
                                    },
                                  ),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                const SizedBox(height: 15.0),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordPage()),
                                      );
                                    },
                                    child: Text(
                                      'password-fogot'.tr,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(170, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: controller.loading
                                          ? const SizedBox(
                                              child: CircularProgressIndicator(
                                                  color: Colors.white),
                                              height: 20.0,
                                              width: 20.0,
                                            )
                                          : Text(
                                              'login'.tr.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                    ),
                                    onPressed: controller.loading
                                        ? null
                                        : () {
                                            FocusScope.of(context).unfocus();

                                            if (_formKey.currentState!
                                                .validate()) {
                                              Get.lazyPut(
                                                  () => AuthController());

                                              _formKey.currentState!.save();
                                              controller
                                                  .signInWithUserAndPassword();
                                            }
                                          },
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  //child: Text('Don\'t have an account? Create'),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'account-none'.tr + ' ?'),
                                        TextSpan(
                                            text: ' ' + 'create'.tr,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const RegistrationPage()));
                                              },
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                    onTap: () =>
                                        launch('tel://' + 'phone-call'.tr),
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'hotline'.tr,
                                        // style: TextStyle(color: Colors.grey),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' ' + 'phone-call'.tr,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
