import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/_controller.dart';
import 'package:khn_tracking/src/views/constansts/constanst.dart';
import 'package:khn_tracking/src/views/pages/auth/widgets/header_auth.dart';

import '../../control_page.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool passwordVisible1 = true;
  bool passwordVisible2 = true;

  Future<void> initData() async {
    // String? mName;
    // mName = await getcontrolNauticaldinates();
    // nauticalIndex = await getcontrolChangePass();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initData(),
      builder: (context, snapshot) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(title: Text('password-change'.tr)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: ValidatorApp.fheaderHeight,
                  child: HeaderAuth(
                      ValidatorApp.fheaderHeight,
                      true,
                      false,
                      Icons
                          .login_rounded), //let's create a common header widget
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: GetBuilder<AuthController>(
                      init: Get.find<AuthController>(),
                      builder: (controller) => Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  labelText: 'password'.tr,
                                  hintText: 'password-desc'.tr,
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    child: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
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
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'password-invalid'.tr;
                                  }
                                },
                                onSaved: (value) {
                                  controller.passwordOld = value!;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              child: TextFormField(
                                obscureText: passwordVisible1,
                                decoration: InputDecoration(
                                  labelText: 'password-new'.tr,
                                  hintText: 'password-new'.tr,
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        passwordVisible1 = !passwordVisible1;
                                      });
                                    },
                                    child: Icon(
                                      passwordVisible1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
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
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'password-invalid'.tr;
                                  }
                                },
                                onSaved: (value) {
                                  controller.passwordNew = value!;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              child: TextFormField(
                                obscureText: passwordVisible2,
                                decoration: InputDecoration(
                                  labelText: 'password-confirm'.tr,
                                  hintText: 'password-confirm'.tr,
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        passwordVisible2 = !passwordVisible2;
                                      });
                                    },
                                    child: Icon(
                                      passwordVisible2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
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
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'password-invalid'.tr;
                                  }
                                },
                                onSaved: (value) {
                                  controller.passwordConfirm = value!;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            const SizedBox(height: 30.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(170, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    'update'.tr.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  _formKey.currentState!.save();
                                  if (_formKey.currentState!.validate()) {
                                    if (controller.passwordNew !=
                                        controller.passwordConfirm) {
                                      Get.snackbar(
                                        'Error',
                                        'Mật khẩu mới không trùng khớp..',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    } else {
                                      await Get.find<AuthController>()
                                          .changePassword(
                                              controller.passwordOld!,
                                              controller.passwordNew!);
                                      if (controller.showDialog) {
                                        _showDialog(context,
                                            'Đổi mật khẩu thành công. Hệ thống sẽ chuyển về trang đăng nhập.');

                                        Future.delayed(
                                            const Duration(seconds: 5), () {
                                          Get.to(() => const ControlPage());
                                        });
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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

  void _showDialog(BuildContext context, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            titlePadding: EdgeInsets.zero,
            title: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0XFF008e76),
                ),
                child: const Center(
                    child: Text('Thông báo',
                        style: TextStyle(fontSize: 16, color: Colors.white)))),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message),
                  const SizedBox(height: 8),
                  const SizedBox(
                      child: CircularProgressIndicator(color: Colors.cyan),
                      height: 20.0,
                      width: 20.0)
                ],
              ),
            ),
          );
        });
  }
}
