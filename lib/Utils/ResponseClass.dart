class ResponseClass<T> {
  final bool isSuccess;
  final T? data;
  final String errorMessage;

  ResponseClass({
    required this.isSuccess,
    required this.data,
    required this.errorMessage,
  });

  factory ResponseClass.success(T data) {
    return ResponseClass(
      isSuccess: true,
      data: data,
      errorMessage: '',
    );
  }

  factory ResponseClass.error(String errorMessage) {
    return ResponseClass(
      isSuccess: false,
      data: null,
      errorMessage: errorMessage,
    );
  }
}
