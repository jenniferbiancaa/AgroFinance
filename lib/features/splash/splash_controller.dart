import 'package:flutter/foundation.dart';

import '../../services/secure_storage.dart';
import '../../services/sync_service.dart';
import 'splash_state.dart';

class SplashController extends ChangeNotifier {

  SplashController({
    required this.secureStorageService,
    required this.syncService,
  });

  final SecureStorageService secureStorageService;
  final SyncService syncService;

  SplashState _state = SplashStateInitial();

  SplashState get state => _state;

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> isUserLogged() async {
    final result = await secureStorageService.readOne(key: "CURRENT_USER");
    if (result != null) {
      _changeState(AuthenticatedUser(message: 'Sicronizando dados do servidor'));

      await syncService.syncFromServer();

      _changeState(AuthenticatedUser(message: 'Sicronizando dados com o servidor'));

      await syncService.syncToServer();

      _changeState(AuthenticatedUser(isReady: true));
    } else {
      _changeState(UnauthenticatedUser());
    }
  }
}