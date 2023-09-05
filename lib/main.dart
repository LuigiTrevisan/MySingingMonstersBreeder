import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list.dart';
import 'teste.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'pt', supportedLocales: ['pt', 'en_US']);

  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        debugShowCheckedModeBanner: false,
        title: 'My Singing Monsters Combiner',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: GoogleFonts.robotoCondensed().fontFamily,
        ),
        home: const MyHomePage(
            title: 'My Singing Monsters Combiner (v0.0.280823.2)'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? counter = '';
  String? combo = '';
  List<String> monsters = getLista("pt");
  String? selectedMonster1;
  String? selectedMonster2;
  String? selectedResult;
  String? resposta;
  List<List<String>>? listCombo;
  String locale = 'pt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate('app_bar.title'),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              underline: const SizedBox(),
              icon: const Icon(Icons.language, color: Colors.white),
              items: const [
                DropdownMenuItem(
                  child: Text('Português'),
                  value: 'pt',
                ),
                DropdownMenuItem(
                  child: Text('English'),
                  value: 'en_US',
                ),
              ],
              onChanged: (value) {
                selectedMonster1 = null;
                selectedMonster2 = null;
                selectedResult = null;
                counter = '';
                combo = '';
                changeLocale(context, value as String?);
                locale = value as String;
                monsters = getLista(value);
              },
            ),
          ),
        ],
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            Text(
              translate('home_page.select'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              children: [
                DropdownButton(
                  hint: Text(
                    translate('home_page.choose_first'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: selectedMonster1,
                  items: monsters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedMonster1 = value;
                    });
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton(
                  hint: Text(
                    translate('home_page.choose_second'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: selectedMonster2,
                  items: monsters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonster2 = newValue!;
                    });
                  },
                ),
              ],
            ),
            Wrap(
              children: [
                IconButton(
                    //Botão de combinar
                    onPressed: () {
                      resposta =
                          monsterSearch(selectedMonster1, selectedMonster2, locale);
                      setState(() {
                        counter = resposta;
                      });
                    },
                    icon: const Icon(Icons.search),
                    padding: const EdgeInsets.all(10),
                    iconSize: 50),
                IconButton(
                    //Botão de limpar
                    onPressed: () {
                      setState(() {
                        selectedMonster1 = null;
                        selectedMonster2 = null;
                        counter = '';
                        combo = '';
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    padding: const EdgeInsets.all(10),
                    iconSize: 50),
              ],
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            DropdownButton(
              hint: Text(
                translate('home_page.choose_result'),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: selectedResult,
              items: monsters.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedResult = newValue!;
                });
              },
            ),
            IconButton(
                onPressed: () {
                  listCombo = comboSearch(selectedResult, locale);
                  setState(() {
                    combo = '';
                    if (listCombo!.isEmpty) {
                      combo = translate("home_page.no_combo");
                    } else {
                      for (var i = 0; i < listCombo!.length; i++) {
                        combo =
                            '${combo!}${listCombo![i][0]} & ${listCombo![i][1]}\n';
                      }
                    }
                  });
                },
                icon: const Icon(Icons.search),
                padding: const EdgeInsets.all(10),
                iconSize: 50),
            Text(
              '$combo',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ]),
    );
  }
}
