import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/values/app_routes.dart';
import 'package:giapha/core/values/app_theme.dart';
import 'package:giapha/features/access/data/models/User.dart';
import 'package:giapha/features/access/presentation/bloc/access_bloc.dart';
import 'package:giapha/features/danhsach_giapha/presentation/pages/danhsach_giapha_screen.dart';

import 'package:giapha/core/extensions/access_extensions.dart';
import '../../../../core/components/app_text_form_field.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_constants.dart';

Widget loginBuilder(BuildContext context) =>
    BlocProvider(
        create: (context) => GetIt.I<AccessBloc>(),
        child: const LoginPage());

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late AccessBloc accessBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    accessBloc = BlocProvider.of<AccessBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Theme(
        data: AppTheme.themeData,
        child: BlocListener<AccessBloc, AccessState>(
          bloc: accessBloc,
          listener: (context, state) {
            if (state is AccessLoadingState) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
              if (state is LoginSuccessState) {
                AnimatedSnackBar.material("Đăng nhập thành công",
                        type: AnimatedSnackBarType.success,
                        duration: const Duration(milliseconds: 2000))
                    .show(context);
              }
              if (state is LoginFailState) {
                AnimatedSnackBar.material("Đăng nhập thất bại",
                        type: AnimatedSnackBarType.error,
                        duration: const Duration(milliseconds: 2000))
                    .show(context);
              }
            }
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.24,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff1E2E3D),
                            Color(0xff152534),
                            Color(0xff0C1C2E),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign in to your\nAccount',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Sign in to your Account',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextFormField(
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              _formKey.currentState?.validate();
                            },
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please, Enter Email Address'
                                  : AppConstants.emailRegex.hasMatch(value)
                                      ? null
                                      : 'Invalid Email Address';
                            },
                            controller: emailController,
                          ),
                          AppTextFormField(
                            labelText: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              _formKey.currentState?.validate();
                            },
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please, Enter Password'
                                  : AppConstants.passwordRegex.hasMatch(value)
                                      ? null
                                      : 'Invalid Password';
                            },
                            controller: passwordController,
                            obscureText: isObscure,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                    const Size(48, 48),
                                  ),
                                ),
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: Theme.of(context).textButtonTheme.style,
                            child: Text(
                              'Quên mật khẩu?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FilledButton(
                            onPressed: _formKey.currentState?.validate() ??
                                    false
                                ? () {
                                    accessBloc.add(SendLoginEvent(UserInfo(
                                        "",
                                        emailController.text,
                                        passwordController.text,
                                        "")));
                                  }
                                : () {
                                    AnimatedSnackBar.material(
                                            "Vui lòng nhập đúng thông tin tài khoản!",
                                            type: AnimatedSnackBarType.warning,
                                            duration: const Duration(
                                                milliseconds: 2000))
                                        .show(context);
                                  },
                            style: const ButtonStyle().copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                _formKey.currentState?.validate() ?? false
                                    ? null
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Hoặc đăng nhập với',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.black),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    AnimatedSnackBar.material(
                                            "Tính năng chưa hỗ trợ",
                                            type: AnimatedSnackBarType.error,
                                            duration: const Duration(
                                                milliseconds: 2000))
                                        .show(context);
                                  },
                                  style: Theme.of(context)
                                      .outlinedButtonTheme
                                      .style,
                                  icon: SvgPicture.asset(
                                    IconConstants.googleIcon,
                                    width: 14,
                                  ),
                                  label: const Text(
                                    'Google',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    AnimatedSnackBar.material(
                                            "Tính năng chưa hỗ trợ",
                                            type: AnimatedSnackBarType.error,
                                            duration: const Duration(
                                                milliseconds: 2000))
                                        .show(context);
                                  },
                                  style: Theme.of(context)
                                      .outlinedButtonTheme
                                      .style,
                                  icon: SvgPicture.asset(
                                    IconConstants.facebookIcon,
                                    width: 14,
                                  ),
                                  label: const Text(
                                    'Facebook',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Chưa có tài khoản?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () =>
                                AppRoutes.registerScreen.pushName(),
                            style: Theme.of(context).textButtonTheme.style,
                            child: Text(
                              'Đăng ký',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
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
          ),
        ));
  }
}
