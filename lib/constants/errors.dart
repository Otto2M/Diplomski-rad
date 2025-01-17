class Errors {
  //--sign up firebase errors

  //if there exists an account with the given email address
  static const emailAlreadyInUse = "emailAlreadyInUse";
  //if the email address is not valid
  static const invalidEmail = "invalidEmail";
  //if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab
  static const operationNotAllowed = "operationNotAllowed";
  //if the password is not strong enough
  static const weakPassword = "weakPassword";
  //Thrown if the user sent too many requests at the same time, for security the api will not allow too many attemps at the same time, user will have to wait for some time
  static const tooManyRequests = "tooManyRequests";
  //if the user is no longer authenticated since his refresh token has been expired
  static const userTokenExpired = "userTokenExpired";
  //if there was a network request error, for example the user don't have internet connection
  static const networkRequestFailed = "networkRequestFailed";
}
