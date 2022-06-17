import 'package:authentication_firebase/core/theme/app_colors.dart';
import 'package:authentication_firebase/modules/authentication/authentication_controller.dart';
import 'package:authentication_firebase/modules/authentication/local_widgets/email_field_auth.dart';
import 'package:authentication_firebase/modules/authentication/local_widgets/password_field_auth.dart';
import 'package:authentication_firebase/modules/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationPage extends GetView<AuthenticationController> {
  static const route = '/auth';

  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: LayoutBuilder(
          builder: (_, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    child: Container(
                      height: constraints.maxHeight * 0.64,
                      decoration: BoxDecoration(
                        color: AppColors.greenMarineLight,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 16,
                            spreadRadius: -4,
                            color: AppColors.blackShadow,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: ListView(
                        children: const [
                          SizedBox(height: 44),
                          LogoSection(),
                          SizedBox(height: 44),
                          AuthSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class LogoSection extends GetView<AuthenticationController> {
  const LogoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteSmoke,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 4,
                spreadRadius: 1,
                color: AppColors.blackShadow,
              ),
            ],
            shape: BoxShape.circle,
          ),
          child: const Padding(
            padding: EdgeInsets.all(36),
            child: Text('Logo'),
          ),
        ),
      ),
    );
  }
}

class AuthSection extends GetView<AuthenticationController> {
  const AuthSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteSmoke,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: AppColors.blackShadow,
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 30),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Autenticação',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      EmailFieldAuth(),
                      const SizedBox(height: 24),
                      PasswordFieldAuth(),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 24,
                          runSpacing: 12,
                          children: [
                            ElevatedButton(
                              onPressed: () => Get.offNamed(SignUpPage.route),
                              child: Text('Não tenho conta', style: TextStyle(color: Colors.grey[900])),
                              style: ElevatedButton.styleFrom(primary: AppColors.white),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                controller.signIn();
                              },
                              child: const Text('Entrar', style: TextStyle(color: AppColors.white)),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.greenMarineLight)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
