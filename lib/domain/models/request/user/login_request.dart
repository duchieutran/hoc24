class LoginRequest {
  final String? username;
  final String? password;
  final String? accessToken;
  final String? refreshToken;

  LoginRequest({
    this.username,
    this.password,
    this.accessToken,
    this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    return {
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
    };
  }
}
