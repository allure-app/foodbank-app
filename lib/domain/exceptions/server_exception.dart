class ServerException extends Error {
  ServerException({String? message}) : _message = message ?? 'Unknown error';
  final String _message;

  @override
  String toString() => _message;
}