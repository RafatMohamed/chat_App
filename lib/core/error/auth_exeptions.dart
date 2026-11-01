String getAuthErrorMessage(String code) {
  switch (code) {
    // Email errors
    case 'invalid-email':
      return 'Invalid email address';

    case 'email-already-in-use':
      return 'This email is already registered';

    case 'missing-email':
      return 'Email address is required';

    // Password errors
    case 'weak-password':
      return 'Password is too weak';

    case 'missing-password':
      return 'Password is required';

    case 'invalid-password':
      return 'Invalid password';

    case 'password-does-not-meet-requirements':
      return 'Password does not meet security requirements';

    // Login credentials
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
    case 'invalid-login-credentials':
      return 'Incorrect email or password';

    // Account errors
    case 'user-disabled':
      return 'This account has been disabled';

    case 'user-token-expired':
    case 'invalid-user-token':
      return 'Your session has expired. Please login again';

    case 'requires-recent-login':
      return 'Please login again to perform this action';

    // Network and security
    case 'network-request-failed':
      return 'Check your internet connection';

    case 'too-many-requests':
      return 'Too many attempts. Try again later';

    case 'quota-exceeded':
      return 'Request limit exceeded. Try again later';

    // Firebase configuration
    case 'operation-not-allowed':
      return 'This authentication method is not enabled';

    case 'internal-error':
    case 'unknown':
    case 'unknown-error':
      return 'An unexpected error occurred. Please try again';

    default:
      return 'Something went wrong. Please try again';
  }
}
