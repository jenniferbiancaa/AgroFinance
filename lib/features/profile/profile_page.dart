import 'package:app_finance/locator.dart';
import 'package:flutter/material.dart';

import '../../common/constants/constants.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../services/secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Perfil"),
            TextButton(
              key: Keys.profilePagelogoutButton,
              onPressed: () async {
                await locator.get<AuthService>().signOut();
                await const SecureStorageService().deleteAll();
                await locator.get<DatabaseService>().deleteDB;
                if (mounted) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}


