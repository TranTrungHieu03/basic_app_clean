import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store_demo/core/common/widgets/show_snackbar.dart';
import 'package:store_demo/core/services/logger.dart';
import 'package:store_demo/core/utils/constants/router.dart';
import 'package:store_demo/init_dependencies.dart';

import 'package:store_demo/core/utils/constants/colors.dart';
import 'package:store_demo/core/utils/constants/images.dart';
import 'package:store_demo/core/utils/constants/sizes.dart';
import 'package:store_demo/features/auth/domain/usecases/login_usecase.dart';
import 'package:store_demo/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:store_demo/features/auth/presentation/cubits/password/password_cubit.dart';
import 'package:store_demo/features/auth/presentation/cubits/password/password_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(TSizes.sm),
          child: Column(
            children: [
              Logo(1.sw),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.sm),
              Text(
                "Welcome back! Please enter your details",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: TSizes.defaultSpace),

              //form login
              BlocProvider<PasswordCubit>(
                create: (context) => sl<PasswordCubit>(),
                child: FormLogin(
                  usernameController: usernameController,
                  passwordController: passwordController,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Forgot password?"),
                ),
              ),
              const SizedBox(height: TSizes.lg),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoaded) {
                    context.go(AppRouter.product);
                  }
                  if (state is AuthError) {
                    TSnackBar.errorSnackBar(context, message: state.message);
                  }
                },
                child: SizedBox(
                  width: 1.sw,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        AuthLoginEvent(
                          LoginDto(
                            password: passwordController.text.toString(),
                            username: usernameController.text.toString(),
                          ),
                        ),
                      );
                    },
                    child: Center(child: Text("Sign in")),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have any account? ",
                      style: Theme.of(
                        context,
                      )!.textTheme.labelLarge!.copyWith(color: Colors.grey),
                    ),
                    TextSpan(
                      text: "Sign up",
                      style: Theme.of(
                        context,
                      )!.textTheme.labelLarge!.copyWith(color: TColors.primary),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container Logo(double width) {
    return Container(
      width: width,
      padding: EdgeInsetsGeometry.all(TSizes.md),
      child: Center(child: Image(image: AssetImage(TImages.logo))),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Key('login-form'),
      child: Column(
        children: [
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: "Username",
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: TSizes.md),
          BlocBuilder<PasswordCubit, PasswordState>(
            builder: (context, state) {
              if (state is PasswordInitial) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: state.isPasswordHidden,
                  // validator: (value) =>
                  //     TValidator.validatePassword(value),
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordHidden
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                      ),
                      onPressed: () {
                        context
                            .read<PasswordCubit>()
                            .togglePasswordVisibility();
                      },
                    ),
                  ),
                );
              } else if (state is PasswordVisibilityToggled) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: state.isPasswordHidden,
                  // validator: (value) =>
                  //     TValidator.validatePassword(value),
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordHidden
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                      ),
                      onPressed: () {
                        context
                            .read<PasswordCubit>()
                            .togglePasswordVisibility();
                      },
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
