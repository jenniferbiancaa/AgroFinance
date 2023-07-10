
import 'package:flutter/material.dart';
import '../../common/constants/constants.dart';
import '../../common/widgets/widgets.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.icewhit,
      body: Column(
        children: [
          const SizedBox(height: 48.0,),
          Expanded(
            flex: 2,
            child: Image.asset('assets/images/agrof.png'),
          ),
          Text(
            'Agrocarteira',
             style: AppTextStyles.mediumText36.copyWith(
             color: AppColors.roxo1,
            )),
          Text(
            'gerencia móvel!',
             style: AppTextStyles.mediumText36.copyWith(
            color: AppColors.roxo1,
            )),
             Padding(
               padding: const EdgeInsets.only(
               left: 32.0,
               right: 32.0,
               top: 16.0,
               bottom: 4.0,
               ),
               child: PrimaryButton(
                key: Keys.onboardingGetStartedButton,
                text: 'Cadastre-Se',
                onPressed: () {
                Navigator.pushNamed(
                  context,
                  NamedRoute.signUp,
                 );
                },
               ),
             ),
            const SizedBox(height: 16.0),

             CustomTexButton(
              key: Keys.onboardingAlreadyHaveAccountButton,
              onPressed: () => Navigator.pushNamed(context, NamedRoute.signIn),
              children: [
                Text(
                'Já tem conta?',
                style: AppTextStyles.smallText.copyWith(
                color: AppColors.black,
                      ),
                    ),
                Text(
                'Login',
                style: AppTextStyles.smallText.copyWith(
                color: AppColors.roxo1,
                      ),
                    )
                ],
             ),
            const SizedBox(height: 40.0,)
        ]
        ),
    );
  }
}

