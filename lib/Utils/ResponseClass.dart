class Response<T> {
  final bool isSuccess;
  final T? data;
  final String errorMessage;

  Response({
    required this.isSuccess,
    required this.data,
    required this.errorMessage,
  });

  // Success response factory method
  factory Response.success(T data) {
    return Response(
      isSuccess: true,
      data: data,
      errorMessage: '',
    );
  }

  // Error response factory method
  factory Response.error(String errorMessage) {
    return Response(
      isSuccess: false,
      data: null,
      errorMessage: errorMessage,
    );
  }
}
