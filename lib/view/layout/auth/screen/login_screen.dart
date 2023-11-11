import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../helper/locale/app_locale_key.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/custom_button/custom_button.dart';
import '../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../../../custom_widgets/validation/validation_mixin.dart';
import '../../wallpaper/screen/home_screen.dart';
import '../controller/auth_controller.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(tr(AppLocaleKey.login)),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  CustomFormField(
                    controller: _emailEC,
                    hintText: tr(AppLocaleKey.email),
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(15),
                  CustomFormField(
                    controller: _passwordEC,
                    hintText: tr(AppLocaleKey.password),
                    isPassword: true,
                    validator: validatePassword,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const Gap(15),
                  CustomButton(
                    text: tr(AppLocaleKey.login),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthController>().login(
                              email: _emailEC.text,
                              password: _passwordEC.text,
                              onSuccess: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  HomeScreen.routeName,
                                  (route) => false,
                                );
                              },
                            );
                      }
                    },
                  ),
                  const Gap(15),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RegisterScreen.routeName,
                      );
                    },
                    child: Text(
                      tr(AppLocaleKey.createAccount),
                    ),
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
