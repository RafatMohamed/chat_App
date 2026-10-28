class AppTexts {
  AppTexts._();

  // Common & App
  static const String appName = 'Chat App';
  static const String recentChat = "Recent Chats";
  static const String somethingWentWrong = 'Something went wrong!';
  static const String somethingWentWrongGeneric = 'Something went wrong';

  // Onboarding
  static const String onboardingSubtitle =
      'Your conversations, all in one place.';

  static String welcomeTo(String appName) => 'Welcome to $appName';
  static const String onboardingDescription =
      'Connect with people and start a conversation.';

  // Authentication - Headers & Subtitles
  static const String welcomeBack = 'Welcome Back';
  static const String loginSubtitle = 'Log in to continue your conversations.';
  static const String createAccount = 'Create Account';
  static const String registerSubtitle =
      'Create an account and start chatting.';
  static const String noChatYet = 'No chats yet';
  static const String findPeople = 'Find People';
  static const String myProfile = 'My Profile';
  static const String inviteContact = 'Invite Contacts';
  static const String findYourPeople = 'Find Your People';
  static const String noChatDesc = "Search for someone to start aconversation.";
  static const String noSearchDesc =
      "Search for someone to start a private conversation.";
  static const String cantFindPeople = "Can't find who you're looking for?";
  static const String inviteQr = "Invite via link or QR code";

  // Authentication - Form Fields & Labels
  static const String emailAddress = 'Email Address';
  static const String fullName = 'full name';
  static const String phoneNumber = "Phone Number";
  static const String enterYourEmail = 'Enter your email';
  static const String password = 'Password';
  static const String enterYourPassword = 'Enter your password';
  static const String enterYourFullName = 'Enter your full name';
  static const String enterYourPhoneNumber = 'Enter your phone number';
  static const String createPassword = 'Create a password';
  static const String confirmYourPassword = 'Confirm your password';

  // Authentication - Actions & Navigation
  static const String forgotPassword = 'Forgot Password?';
  static const String searchAbout = 'Search people by name or email';
  static const String resetPassword = 'Reset Password?';
  static const String logIn = 'Log In';
  static const String logOut = 'Log Out';
  static const String editeProfile = 'Edit Profile';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String alreadyHaveAccount = 'Already have an account? ';

  // Form Validation
  static const String fieldRequired = 'this field is required';
  static const String enterValidEmail = 'enter valid email';
  static const String strongPasswordPlease = 'strong password please';
  static const String samePassword = 'same password';
  static const String enterValidUsername = 'enter valid username';
  static const String enterNumbersOnly = 'enter numbers only';
  static const String enterValueMustEqual11Digit =
      'enter value must equal 11 digit';

  // Chat
  static const String justNow = 'just now';

  static String hi(String username) => 'Hi $username';

  static String sentVerification(String email) =>
      'We sent a verification code to $email. Please enter it below:';
  static const String typeMessage = 'Type a message';
  static const String message = 'Message';

  // Password Reset Feedback & Errors
  static String passwordResetLinkSent(String email) =>
      'Password reset link sent to $email';

  static String failedToSendResetEmail(String error) =>
      'failed to send reset email $error';

  // Authentication Feedback & Errors
  static const String userNotFound = 'No user found for that email.';
  static const String wrongPassword = 'Incorrect password.';
  static const String peopleFound = 'people found';
  static const String invalidCredential =
      'Invalid email or password. Please check and try again.';
  static const String invalidEmailAddress =
      'The email address is badly formatted.';
  static const String userDisabled = 'This user account has been disabled.';
  static const String tooManyRequests =
      'Too many login attempts. Try again later.';
  static const String authFailed =
      'Authentication failed. Please try again later.';
  static const String weakPassword = 'The password provided is too weak.';
  static const String emailAlreadyInUse =
      'The account already exists for that email.';
  static const String operationNotAllowed =
      'Email/password accounts are not enabled. Please check your Firebase authentication settings.';
  static const String unknownError =
      'An unknown error occurred. Please try again later.';
  static const String noInternetConnection =
      'No internet connection. Please check your network settings.';

  static String oopsSomethingWentWrong(String error) =>
      'Oops, something went wrong: $error';

  static String oopsExclamationSomethingWentWrong(String error) =>
      'Oops! Something went wrong: $error';

  static const String chat = 'Chats';
  static const String search = 'Search';
  static const String profile = 'Profile';
}
