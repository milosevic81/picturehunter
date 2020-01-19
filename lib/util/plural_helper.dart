class Plurals {
  static int getPluralForm(int n) {
    // taken from: https://l10n.gnome.org/teams/sr/
    if (n % 10 == 1 && n % 100 != 11) {
      return 0;
    }

    if (n % 10 >= 2 && n % 10 <= 4 && (n % 100 < 10 || n % 100 >= 20)) {
      return 1;
    }

    return 2;
  }
}