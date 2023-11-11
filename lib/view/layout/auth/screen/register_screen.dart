import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../helper/locale/app_locale_key.dart';
import '../../../../helper/theme/app_text_style.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/custom_button/custom_button.dart';
import '../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../../../custom_widgets/validation/validation_mixin.dart';
import '../../wallpaper/screen/home_screen.dart';
import '../controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  final _fNameEC = TextEditingController();
  final _lNameEC = TextEditingController();
  final _phoneEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _fNameEC.dispose();
    _lNameEC.dispose();
    _phoneEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(tr(AppLocaleKey.createAccount)),
          automaticallyImplyLeading: true,
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  CustomFormField(
                    controller: _fNameEC,
                    hintText: tr(AppLocaleKey.firstName),
                    validator: validateName,
                  ),
                  const Gap(15),
                  CustomFormField(
                    controller: _lNameEC,
                    hintText: tr(AppLocaleKey.lastName),
                    validator: validateName,
                  ),
                  const Gap(15),
                  CustomFormField(
                    controller: _emailEC,
                    hintText: tr(AppLocaleKey.email),
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(15),
                  CustomFormField(
                    controller: _phoneEC,
                    hintText: tr(AppLocaleKey.phone),
                    prefixIcon: const SizedBox(
                      height: 47,
                      width: 47,
                      child: Center(
                        child: Text(
                          '+1',
                          style: AppTextStyle.textFormStyle,
                        ),
                      ),
                    ),
                    validator: validatePhone,
                    keyboardType: TextInputType.phone,
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
                    text: tr(AppLocaleKey.createAccount),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthController>().register(
                            firstName: _fNameEC.text,
                            lastName: _lNameEC.text,
                            email: _emailEC.text,
                            phone: _phoneEC.text,
                            password: _passwordEC.text,
                            onSuccess: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeName,
                                (route) => false,
                              );
                            });
                      }
                    },
                  ),
                  const Gap(15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      tr(AppLocaleKey.login),
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
