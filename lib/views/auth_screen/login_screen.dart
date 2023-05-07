import 'dart:math';

import 'package:abdar_seller/Controllers/auth_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/home_screen/home.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/my_button.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 80,
                    height: 120,
                  ),
                  boldText(
                    text: appname,
                    size: 20.0,
                  )
                ],
              ),
              30.heightBox,
              Obx(
                () => Column(
                  children: [
                    boldText(text: login, color: greenColor, size: 30.0),
                    20.heightBox,
                    TextFormField(
                      controller: controller.emailController,
                      cursorColor: Vx.black,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: backgroundColor,
                          ),
                          border: InputBorder.none,
                          hintText: emailHint),
                    ),
                    10.heightBox,
                    TextFormField(
                      controller: controller.passwordController,
                      obscureText: true,
                      cursorColor: Vx.black,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: backgroundColor,
                          ),
                          border: InputBorder.none,
                          hintText: passwordHint),
                    ),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: boldText(
                                text: forgotPassword, color: greenColor))),
                    SizedBox(
                      width: context.screenWidth - 60,
                      child: controller.isLoading.value
                          ? loadingIndicator()
                          : myButton(
                              title: login,
                              onPress: () async {
                                controller.isLoading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context,
                                        msg: 'Logged in successfully');
                                    controller.isLoading(false);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              },
                            ),
                    ),
                  ],
                )
                    .box
                    .white
                    .roundedSM
                    .outerShadowSm
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              const Spacer(),
              Center(child: boldText(text: credit, color: greenColor)),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
