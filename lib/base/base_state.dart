class BaseViewState<T> {
  bool? isLoading;
  bool isSuccess;
  BaseError? error;
  T? data;

  BaseViewState(
      {this.isLoading, this.isSuccess = false, this.error, this.data});

  get hasData => this.isSuccess && this.data != null;

  get hasError => error != null && error!.message.isNotEmpty;

  BaseViewState<T> copyWith(
      {bool? isLoading, bool isSuccess = false, BaseError? error, T? data}) {
    return BaseViewState<T>(
      data: data,
      isLoading: isLoading,
      isSuccess: isSuccess,
      error: error,
    );
  }
}

class BaseError {
  final String message;
  final ErrorType type;

  BaseError(this.message, {this.type = ErrorType.apiError});
}

enum ErrorType {
  apiError,
  validationError;
}
