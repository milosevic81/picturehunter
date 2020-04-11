import 'package:test/test.dart';
import 'package:picturehunter/util/checker.dart';

void main() {
  test('No solutions given', () {
    expect(Checker.checkAnswer(null, ""), GuessType.NOT_GUESSED);
    expect(Checker.checkAnswer([], null), GuessType.NOT_GUESSED);
    expect(Checker.checkAnswer([], ""), GuessType.NOT_GUESSED);
    expect(Checker.checkAnswer([], "kruska"), GuessType.NOT_GUESSED);
  });

  test('One solution given', () {
    expect(Checker.checkAnswer(["kruska"], "kruska"), GuessType.GUESSED);
    expect(Checker.checkAnswer(["kruska"], "крушка"), GuessType.GUESSED);
    expect(Checker.checkAnswer(["kruska"], "kruška"), GuessType.GUESSED);

    expect(Checker.checkAnswer(["dz ccc zdj"], "џ цчћ жђ"), GuessType.GUESSED);
    expect(Checker.checkAnswer(["dz ccc zdj"], "dž cčć žđ"), GuessType.GUESSED);
    expect(Checker.checkAnswer(
        ["ajso lepoto i ceznjo za ljubav srca mog dodji u hadzice na kafu"],
        "Ајшо лепото и чежњо за љубав срца мог дођи у Хаџиће на кафу"),
        GuessType.GUESSED);
    expect(Checker.checkAnswer(
        ["Ајшо лепото и чежњо за љубав срца мог дођи у Хаџиће на кафу"],
        "ajso lepoto i ceznjo za ljubav srca mog dodji u hadzice na kafu"),
        GuessType.GUESSED);

    // letter missing
    expect(Checker.checkAnswer(["kruska"], "ruška"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "ruska"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "krušk"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "krusk"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "kruša"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "krusa"), GuessType.SIMILAR);
    // letter changed
    expect(Checker.checkAnswer(["kruska"], "kruške"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "kruske"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "krbška"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "krbska"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "fruška"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "fruska"), GuessType.SIMILAR);
    // letter added
    expect(Checker.checkAnswer(["kruska"], "kruškea"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "kruskea"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "akruška"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "akruska"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "kruuška"), GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska"], "kruuska"), GuessType.SIMILAR);
  });

  test('More solutions given', () {
    expect(Checker.checkAnswer(["kruska", "kruske"], "kruska"),
        GuessType.GUESSED);
    expect(Checker.checkAnswer(["kruska", "kruske"], "kruske"),
        GuessType.GUESSED);
    expect(Checker.checkAnswer(["kruska", "kruske"], "крушке"),
        GuessType.GUESSED);
    expect(Checker.checkAnswer(["kruska", "kruske"], "kruške"),
        GuessType.GUESSED);

    expect(Checker.checkAnswer(["kruska", "kruske"], "kruskaa"),
        GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska", "kruske"], "kruskee"),
        GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska", "kruske"], "ruske"),
        GuessType.SIMILAR);
    expect(Checker.checkAnswer(["kruska", "kruske"], "ruшka"),
        GuessType.SIMILAR);

    expect(Checker.checkAnswer(["kruska", "kruske"], ""),
        GuessType.NOT_GUESSED);
    expect(Checker.checkAnswer(["kruska", "kruske"], "kruskеее"),
        GuessType.NOT_GUESSED);
    expect(Checker.checkAnswer(["kruska", "kruske"], "kruskaaа"),
        GuessType.NOT_GUESSED);
    expect(Checker.checkAnswer(["kruska", "kruske"], "круш"),
        GuessType.NOT_GUESSED);
  });
}