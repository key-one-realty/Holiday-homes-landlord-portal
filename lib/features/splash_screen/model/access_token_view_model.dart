class TokenVerifierResponse {
  final bool success;
  final String message;

  TokenVerifierResponse({
    required this.success,
    required this.message,
  });

  factory TokenVerifierResponse.fromJson(Map<String, dynamic> json) {
    return TokenVerifierResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}
