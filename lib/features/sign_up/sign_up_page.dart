import 'dart:developer';
import 'package:app_finance/features/sign_up/sign_up_controller.dart';
import 'package:app_finance/features/sign_up/sign_up_state.dart';
import 'package:app_finance/locator.dart';
import 'package:flutter/material.dart';

import '../../common/constants/constants.dart';
import '../../common/utils/utils.dart';
import '../../common/widgets/widgets.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with CustomModalSheetMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signUpController = locator.get<SignUpController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _signUpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _signUpController.addListener(
      () {
        if (_signUpController.state is SignUpStateLoading) {
          showDialog(
            context: context,
           builder: (context) => const CustomCircularProgressIndicator(),
          );
        }
        if (_signUpController.state is SignUpStateSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            NamedRoute.home,
          );
        }

        if (_signUpController.state is SignUpStateError) {
          final error = _signUpController.state as SignUpStateError;
          Navigator.pop(context);
          showCustomModalBottomSheet(
            context: context,
            content: error.message,
            buttonText: "Tentar novamente",
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        key: Keys.signUpListView,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'ECONOMIZE SEU',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(
              color: AppColors.roxo1,
            ),
          ),
          Text(
            'DINHEIRO!',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(
              color: AppColors.roxo1,
            ),
          ),
          Image.asset(
            'assets/images/top.png',
            width: 100, // Ajuste a largura conforme necessário
           height: 250, // Ajuste a altura conforme necessário
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  key: Keys.signUpNameField,
                  controller: _nameController,
                  labelText: "nome completo",
                  hintText: "digite seu nome",
                  inputFormatters: [
                    UpperCaseTextInputFormatter(),
                  ],
                   validator: Validator.validateName,
                ),
                CustomTextFormField(
                  key: Keys.signUpEmailField,
                  controller: _emailController,
                  labelText: "email",
                  hintText: "usuario@gmail.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  key: Keys.signUpPasswordField,
                  controller: _passwordController,
                  labelText: "senha",
                  hintText: "*********",
                  validator: Validator.validatePassword,
                  helperText:
                      "Deve ter pelo menos 8 caracteres, 1 letra maiúscula e 1 número.",
                ),
                PasswordFormField(
                  key: Keys.signUpConfirmPasswordField,
                  labelText: "confirme a senha",
                  hintText: "*********",
                  validator: (value) => Validator.validateConfirmPassword(
                    _passwordController.text,
                    value,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              key: Keys.signUpButton,
              text: 'Cadastrar',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _signUpController.signUp(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  log("erro ao logar");
                }
              },
            ),
          ),
          CustomTexButton(
            key: Keys.signUpAlreadyHaveAccountButton,
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoute.signIn,
            ),
            children: [
              Text(
                'Já tem conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Login',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.roxo1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
