
import 'package:app_finance/common/constants/app_colors.dart';
import 'package:app_finance/common/constants/app_text_styles.dart';
import 'package:app_finance/features/splash/splash_controller.dart';
import 'package:app_finance/locator.dart';
import 'package:flutter/material.dart';
import '../../common/extensions/sizes.dart';
import 'splash_state.dart';
import '../../common/constants/routes.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashController = locator.get<SplashController>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => Sizes.init(context));
   
    _splashController.isUserLogged();
    _splashController.addListener(() {
      if (_splashController.state is AuthenticatedUser) {
        final state = _splashController.state as AuthenticatedUser;
        if (state.isReady) {
          Navigator.pushReplacementNamed(
            context,
            NamedRoute.home,
          );
        }
      } else {
        Navigator.pushReplacementNamed(
          context,
          NamedRoute.initial,
        );
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,  
          colors:AppColors.roxoGradient)
        ),
        child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset(
      'assets/images/agrof.png',
      width: 300, // Ajuste a largura conforme necessário
      height: 300, // Ajuste a altura conforme necessário
    ),
    AnimatedBuilder(
      animation: _splashController,
      builder: (context, _) {
        if (_splashController.state is AuthenticatedUser) {
          final state = _splashController.state as AuthenticatedUser;
          return Text(
            state.message,
            style: AppTextStyles.smallText13.copyWith(color: AppColors.white),
          );
        }
        return const SizedBox.shrink();
      },
    ),
    const SizedBox(height: 16.0),
    const CustomCircularProgressIndicator(),
  ],
),

      ),
    );
  }
}