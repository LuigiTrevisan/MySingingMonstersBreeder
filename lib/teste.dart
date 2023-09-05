import 'package:msm/dict.dart';

String monsterSearch(String? monster1, String? monster2, String locale) {
  var dict = getDict(locale: locale);
  if (monster1 == null || monster2 == null) return '';
  if (monster1 == monster2) return monster1;
  return dict[monster1][monster2] ?? '';
}

List<List<String>> comboSearch(String? result, String locale) {
  var dict = getDict(locale: locale);
  if (result == null) return [];
  var combos = <List<String>>[];
  for (var monster1 in dict.keys) {
    for (var monster2 in dict[monster1].keys) {
      if (dict[monster1][monster2] == result) {
        combos.add([monster1, monster2]);
      }
    }
  }
  return combos;
}
