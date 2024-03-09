class ApiUrls {
  // static String server = "http://localhost:5000";
  static String server = "https://69a1-139-135-38-228.ngrok-free.app";

  /// USER
  static String signup = "$server/api/addUser";
  static String login = "$server/api/login";
  static String sendOtp = "$server/api/user/sendEmail";
  static String delete = "$server/api/user/userId";
  static String update = "$server/api/user/userId";
  static String resetPassword = "$server/api/user/resetPassword";
  static String addProfile = "$server/profile/addProfile";
  static String allProfiles = "$server/profile/allProfiles";
  static String userId = "$server/profile/userId";
  static String deleteUserId = "$server/profile/userId";
  static String updateUserId = "$server/profile/userId";
}
