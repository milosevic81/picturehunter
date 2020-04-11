enum GuessType {
  GUESSED,
  SIMILAR,
  NOT_GUESSED
}

class Checker {
  static GuessType checkAnswer(List solutions, String guess) {
    if (solutions?.isEmpty ?? true) return GuessType.NOT_GUESSED;
    if (guess?.isEmpty ?? true) return GuessType.NOT_GUESSED;

    bool hadSimilar = false;
    for (var i=0;i < solutions.length; i++) {
      var guessType = _str2strGuess(solutions[i], guess);
      if (guessType == GuessType.GUESSED) {
        return GuessType.GUESSED;
      } else if (guessType == GuessType.SIMILAR) {
        hadSimilar = true;
      }
    }

    return hadSimilar ? GuessType.SIMILAR : GuessType.NOT_GUESSED;
  }

  static GuessType _str2strGuess(solution, guess) {
    String normalizedSolution = normalize(solution);
    String normalizedGuess = normalize(guess);
    if (normalizedSolution == normalizedGuess) {
      return GuessType.GUESSED;
    }

    if ((normalizedSolution.length - normalizedGuess.length).abs() > 1) {
      return GuessType.NOT_GUESSED;
    }

    if (normalizedSolution.length == normalizedGuess.length) {
      if (_isOneLetterChanged(normalizedSolution, normalizedGuess)) {
        return GuessType.SIMILAR;
      } else {
        return GuessType.NOT_GUESSED;
      }
    }

    if (normalizedSolution.length > normalizedGuess.length) {
      if (_isOnlyOneLetterMissing(normalizedSolution, normalizedGuess)) {
        return GuessType.SIMILAR;
      } else {
        return GuessType.NOT_GUESSED;
      }
    } else {
      if (_isOnlyOneLetterMissing(normalizedGuess, normalizedSolution)) {
        return GuessType.SIMILAR;
      } else {
        return GuessType.NOT_GUESSED;
      }
    }
  }

  static bool _isOneLetterChanged(String str1, String str2) {
    // assert strippedGuess.length() == strippedRealLogoName.length()
    int fails = 0;
    for (var i = 0; i < str1.length; i++) {
      if (str1[i] != str2[i]) fails++;
      if (fails > 1) return false;
    }

    return true;
  }

  static bool _isOnlyOneLetterMissing(String strLonger, String str) {
    var offset = 0;
    for (var i = 0; i < strLonger.length; i++) {
      if ((offset == 0) && (i == strLonger.length-1)) {
        return true;
      }
      var c1 = strLonger[i];
      var c2 = str[i - offset];
      if (c1 != c2) offset++;
      if (offset > 1) return false;
    }

    return true;
  }

  static String normalize(String str) {
    StringBuffer buffer = new StringBuffer();
    for (var i=0; i<str.length; i++) {
      var ch = str[i].toLowerCase().trim();
      switch (ch) {
        case ' ': { /* skip space */} break;
        // latin letters
        case 'š': { buffer.write('s'); } break;
        case 'č': { buffer.write('c'); } break;
        case 'ć': { buffer.write('c'); } break;
        case 'ž': { buffer.write('z'); } break;
        case 'đ': { buffer.write('dj'); } break;
        // cyrillic
        case 'а': { buffer.write('a'); } break; // 1
        case 'б': { buffer.write('b'); } break; // 2
        case 'в': { buffer.write('v'); } break; // 3
        case 'г': { buffer.write('g'); } break; // 4
        case 'д': { buffer.write('d'); } break; // 5
        case 'ђ': { buffer.write('dj'); } break; // 6
        case 'е': { buffer.write('e'); } break; // 7
        case 'ж': { buffer.write('z'); } break; // 8
        case 'з': { buffer.write('z'); } break; // 9
        case 'и': { buffer.write('i'); } break; // 10
        case 'ј': { buffer.write('j'); } break; // 11
        case 'к': { buffer.write('k'); } break; // 12
        case 'л': { buffer.write('l'); } break; // 13
        case 'љ': { buffer.write('lj'); } break; // 14
        case 'м': { buffer.write('m'); } break; // 15
        case 'н': { buffer.write('n'); } break; // 16
        case 'њ': { buffer.write('nj'); } break; // 17
        case 'о': { buffer.write('o'); } break; // 18
        case 'п': { buffer.write('p'); } break; // 19
        case 'р': { buffer.write('r'); } break; // 20
        case 'с': { buffer.write('s'); } break; // 21
        case 'т': { buffer.write('t'); } break; // 22
        case 'ћ': { buffer.write('c'); } break; // 23
        case 'у': { buffer.write('u'); } break; // 24
        case 'ф': { buffer.write('f'); } break; // 25
        case 'х': { buffer.write('h'); } break; // 26
        case 'ц': { buffer.write('c'); } break; // 27
        case 'ч': { buffer.write('c'); } break; // 28
        case 'џ': { buffer.write('dz'); } break; // 29
        case 'ш': { buffer.write('s'); } break; // 30
        default:
          { buffer.write(ch); }
          break;
      }
    }

    return buffer.toString();
  }
}