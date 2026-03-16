import 'dart:core';

sealed class Result<T> {
  const Result();
  factory Result.ok(T value) => Ok(value);
  factory Result.error(Error error) => Err(error);
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.error);
  final Error error;
}

final class None {
  const None();
}