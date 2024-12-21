class AppUrls {
  static const String baseUrl = 'http://192.168.1.4:5000/milestone-api/services/v1';
  
  // User Login Endpoint
  static String login = '$baseUrl/login';
  
  // User creation endpoint
  static String createUser = '$baseUrl/user';
  
  // Example: User fetching endpoint
  static String getUser(String userIdentifier) {
    return '$baseUrl/user/$userIdentifier';
  }
  
  // Other endpoints can be added here as needed
}
