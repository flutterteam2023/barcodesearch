bool isUpperCharacter(String character) {
  assert(character.length == 1, 'character is must be lengt 1');

  return character[0] == character[0].toUpperCase();
}

bool isLowerCharacter(String character) {
  assert(character.length == 1, 'character is must be lengt 1');

  return character[0] == character[0].toLowerCase();
}

String firstLetterChangeToLower(String text) {
  List<String> l = text.split("");
  l[0] = l[0].toLowerCase();
  return l.join();
}
