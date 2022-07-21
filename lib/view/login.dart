import 'package:bk9/controller/login_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundImage(),
            Column(
              children: [
                CustomTextField(
                    width: 90,
                    height: 6,
                    borderRadius: 30,
                    textEditingController: loginController.emailTextField,
                    textInputType: TextInputType.text,
                    suffixIcon: Center(),
                    prefixIcon: Icon(Icons.email),
                    onChanged: (_){},
                    obscureText: true,
                    labelText: 'email',
                    maxLength: 2,
                    borderColor: Colors.red,
                    focusedBorderColor: Colors.deepOrange,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
