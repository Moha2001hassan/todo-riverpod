import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_riverpod/core/common_widgets/async_value_ui.dart';
import 'package:todo_riverpod/features/auth/presentation/controllers/auth_controller.dart';
import 'package:todo_riverpod/utils/styles.dart';

import '../../../../core/helpers/show_snackbar.dart';
import '../../../../core/routes/routes.dart';
import '../../../../utils/size_config.dart';
import '../widgets/common_text_field.dart';
import '../widgets/login_icon_btn.dart';
import '../widgets/or_divider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final state = ref.watch(authControllerProvider);
    ref.listen(authControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.getProportionateWidth(10),
            right: SizeConfig.getProportionateWidth(10),
            top: SizeConfig.getProportionateHeight(50),
            bottom: 0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'SignIn to your account 👋',
                  style: AppStyles.titleTextStyle,
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(25)),
                CommonTextField(
                  controller: _emailController,
                  hintText: 'Enter Email...',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(10)),
                CommonTextField(
                  controller: _passwordController,
                  hintText: 'Enter Password...',
                  isObscure: true,
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(25)),
                // CommonButton(title: 'SignIn', onTap: () {}),
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: _validateDetails,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      alignment: Alignment.center,
                      height: SizeConfig.getProportionateHeight(50),
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'SignIn',
                              style: AppStyles.titleTextStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(10)),
                OrDivider(),
                SizedBox(height: SizeConfig.getProportionateHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LoginIconBtn(
                      onTap: () {},
                      icon: FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    LoginIconBtn(
                      onTap: () {},
                      icon: FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                    LoginIconBtn(
                      onTap: () {},
                      icon: FontAwesomeIcons.apple,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: AppStyles.normalTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(AppRouter.register.name);
                      },
                      child: Text(
                        'SignUp',
                        style: AppStyles.normalTextStyle.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateDetails() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackBar(
        context: context,
        message: 'Please fill all the fields',
        color: Colors.red,
      );
    } else {
      ref
          .read(authControllerProvider.notifier)
          .signInWithEmailAndPassword(email: email, password: password);
    }
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
