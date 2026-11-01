
/// Base Result class
/// [S] represents the type of the success value
/// [E] should be [Exception] or a subclass of it
library;

sealed class Result<S, E extends Exception> {
  const Result();

  bool get isSuccess => this is Success;

  bool get isFailure => this is Failure;

  S get getSuccessValue => (this as Success).value as S;
  E get getFailureException => (this as Failure).exception as E;

  T when<T>({
    required T Function(S value) onSuccess,
    required T Function(E exception) onFailure,
  }) {
    if (isSuccess) {
      return onSuccess(getSuccessValue);
    } else {
      return onFailure(getFailureException);
    }
  }
}


final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}


final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}
