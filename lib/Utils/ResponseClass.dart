class ResponseClass<T> {
  final bool isSuccess;
  final T? data;
  final String errorMessage;

  ResponseClass({
    required this.isSuccess,
    required this.data,
    required this.errorMessage,
  });

  // Success response factory method
  factory ResponseClass.success(T data) {
    return ResponseClass(
      isSuccess: true,
      data: data,
      errorMessage: '',
    );
  }

  // Error response factory method
  factory ResponseClass.error(String errorMessage) {
    return ResponseClass(
      isSuccess: false,
      data: null,
      errorMessage: errorMessage,
    );
  }
}
