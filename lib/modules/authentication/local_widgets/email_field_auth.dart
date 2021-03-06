import 'package:authentication_firebase/core/util/validations.dart';
import 'package:authentication_firebase/global_widgets/standard_text_form_field.dart';
import 'package:authentication_firebase/modules/authentication/authentication_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailFieldAuth extends GetView<AuthenticationPageController> {
  const EmailFieldAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      label: 'Email',
      validator: validateEmail,
      onChanged: onChanged,
      onFieldSubmitted: (_) => controller.authPasswordFocusNode.requestFocus(),
      focusNode: controller.authEmailFocusNode,
    );
  }

  void onChanged(String? email) {
    if (email == null || email.isEmpty) {
      controller.authEmail.value = '';
      return;
    }

    controller.authEmail.value = email;
  }
}
