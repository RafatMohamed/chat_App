String generateChatId(String text1, String text2) {
  final title = [text1, text2]..sort();
  final result = title.join("_");
  return result;
}
