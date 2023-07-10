abstract class Failure implements Exception {
  const Failure();

  String get message;

  @override
  String toString() {
    return '$runtimeType Exception';
  }
}

class GeneralException extends Failure {
  const GeneralException();

  @override
  String get message => 'Ocorreu um erro. Por favor, tentar mais tarde.';
}

//API Exceptions

class APIException extends Failure {
  const APIException({
    required this.code,
    this.textCode,
  });

  final int code;
  final String? textCode;

  @override
  String get message {
    if (textCode != null) {
      switch (textCode) {
        case 'invalid-headers':
        case 'validation-failed':
          return 'Solicitação inválida. Verifique sua solicitação e tente novamente.';
        default:
          return 'Ocorreu um erro interno. Por favor, tente novamente mais tarde.';
      }
    }
    switch (code) {
      case 400:
        return 'Solicitação inválida. Verifique sua solicitação e tente novamente.';
      case 401:
        return 'Usuário não autorizado a acessar este recurso no momento. ';
      case 404:
        return 'Não foi possível finalizar esta operação. Por favor tente novamente mais tarde.';
      case 503:
        return 'Serviço indisponível no momento. Por favor tente novamente mais tarde.';
      default:
        return 'Ocorreu um erro interno. Por favor, tente novamente mais tarde.';
    }
  }
}

//Services Exceptions
class AuthException extends Failure {
  const AuthException({
    required this.code,
  });

  final String code;

  @override
  String get message {
    switch (code) {
      case 'session-expired':
      case 'invalid-jwt':
      case 'invalid-headers':
      case 'user-not-authenticated':
        return 'Sua sessão expirou. Faça login novamente.';
      case 'email-already-exists':
        return 'O e-mail fornecido já está em uso. Verifique suas informações ou crie uma nova conta.';
      case 'user-not-found':
      case 'wrong-password':
        return 'E-mail ou senha estão incorretos. Verifique suas informações ou crie uma conta.';
      case 'network-request-failed':
        return 'Não foi possível conectar ao servidor remoto. Verifique sua conexão e tente novamente.';
      case 'too-many-requests':
        return 'Devido a tentativas falhadas consecutivas, você não pode fazer login neste momento. Por favor, tente novamente em alguns instantes.';
      case 'internal':
        return 'Não foi possível criar sua conta neste momento. Verifique suas informações e tente novamente.';
      default:
        return 'Ocorreu um erro durante a autenticação. Por favor, tente novamente mais tarde.';
    }
  }
}

class SecureStorageException extends Failure {
  const SecureStorageException();

  @override
  String get message => 'Ocorreu um erro ao obter o armazenamento seguro.';
}

class CacheException extends Failure {
  const CacheException({required this.code});

  final String code;


  @override
  String get message {
    switch (code) {
      case 'write':
        return 'Ocorreu um erro ao gravar dados no cache local.';
      case 'read':
        return 'Ocorreu um erro ao ler os dados no cache local.';
      case 'delete':
        return 'Ocorreu um erro ao excluir dados no cache local.';
      case 'update':
        return 'Ocorreu um erro ao atualizar dados no cache local.';
      default:
        return 'Ocorreu um erro ao acessar os dados do cache local.';
    }
  }
  
}

//System Exceptions
class ConnectionException extends Failure {
  const ConnectionException({
    required this.code,
  });

  final String code;

  @override
  String get message {
    switch (code) {
      case 'connection-error':
        return 'Não foi possível conectar ao servidor remoto. Verifique sua conexão e tente novamente.';
      default:
        return 'Ocorreu um erro interno. Por favor, tente novamente mais tarde.';
    }
  }
}

class SyncException extends Failure {
  const SyncException({required this.code});

  final String code;
  @override
  String get message {
    switch (code) {
      case 'error':
        return 'error while syncing';
      default:
        return 'unkown error';
    }
  }
}