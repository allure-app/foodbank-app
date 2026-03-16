typedef ValidationErrors = Map<String, List<String>>;

class ValidationException extends Error {
  ValidationException(ValidationErrors errors) : _errors = errors;
  final ValidationErrors _errors;
  ValidationErrors get errors => _errors;
}