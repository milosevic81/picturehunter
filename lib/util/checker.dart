class Checker {
  static bool checkAnswer(List solutions, String text) {
    var normal = normalize(text);
    for (final s in solutions) {
      if (normalize(s) == normal) return true;
    }
    return false;
  }

  static String normalize(String str) {
    return str.toLowerCase().trim().substring(0, str.length - 1);
  }
}
