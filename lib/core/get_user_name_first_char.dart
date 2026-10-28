String getUserChar(String name) {
  // String name = "Raafat  KO   Mohamed";
  // final user = name.split(" ");
  // final firstName = user[0].substring(0, 1).toUpperCase();
  // user.removeAt(0);
  // while (user.first.isEmpty) {
  //   user.remove(user.first);
  // }
  // final lastName = user[0].substring(0, 1).toUpperCase();
  // print("$firstName$lastName");

  final parts = name.trim().split(RegExp(r'\s+'));

  if (parts.isEmpty || parts.first.isEmpty) {
    return '';
  }

  final firstChar = parts.first[0].toUpperCase();

  if (parts.length == 1) {
    return firstChar;
  }

  final lastChar = parts.last[0].toUpperCase();

  return '$firstChar$lastChar';
}
