import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('fa');
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dffffff);
    Color primaryColor = Colors.pink.shade400;
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfige.dark().gettheme(_locale.languageCode)
          : MyAppThemeConfige.light().gettheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark)
              _themeMode = ThemeMode.light;
            else
              _themeMode = ThemeMode.dark;
          });
        },
        selectedLanguageChang: (_Language newSelectedLanguageByUser) {
          setState(() {
            _locale = newSelectedLanguageByUser == _Language.en
                ? Locale('en')
                : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfige {
  static const String faPrimaryFamliy = 'IranYekan';
  final Color primaryTextColor;
  final Color secendryTextColor;
  final Color surfaceColor;
  final Color backgroundcolor;
  final Color appBarColor;
  final Brightness brightness;

  ThemeData gettheme(String languageCode) {
    return ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.blue,
      primaryColor: Colors.pink.shade400,
      brightness: brightness,
      scaffoldBackgroundColor: backgroundcolor,
      appBarTheme: AppBarTheme(
          backgroundColor: appBarColor, foregroundColor: primaryTextColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundcolor))),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: surfaceColor,
      ),
      textTheme: languageCode == 'en' ? enPrimaryTextTheam : faPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheam => GoogleFonts.latoTextTheme(TextTheme(
        bodyText2: TextStyle(fontSize: 18, color: primaryTextColor),
        bodyText1: TextStyle(fontSize: 13, color: secendryTextColor),
        headline6:
            TextStyle(fontWeight: FontWeight.w900, color: primaryTextColor),
        subtitle1: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: primaryTextColor),
      ));
  TextTheme get faPrimaryTextTheme => TextTheme(
        bodyText2: TextStyle(
            fontSize: 18, color: primaryTextColor, fontFamily: faPrimaryFamliy),
        bodyText1: TextStyle(
            fontSize: 13,
            color: secendryTextColor,
            fontFamily: faPrimaryFamliy),
        caption: TextStyle(fontFamily: faPrimaryFamliy),
        headline6: TextStyle(
            fontWeight: FontWeight.w900,
            color: primaryTextColor,
            fontFamily: faPrimaryFamliy),
        subtitle1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: faPrimaryFamliy),
      );

  MyAppThemeConfige.dark()
      : primaryTextColor = Colors.white,
        secendryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundcolor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfige.light()
      : primaryTextColor = Colors.grey.shade900,
        secendryTextColor = Colors.grey.shade900,
        surfaceColor = Color(0x0d000000),
        backgroundcolor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChang;
  const MyHomePage(
      {Key? key,
      required this.toggleThemeMode,
      required this.selectedLanguageChang})
      : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum _SkillType { photoshop, xd, illusterator, affterEffect, lightRoom }
enum _Language {
  en,
  fa,
}

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.fa;

  void _updateSelectSkill(_SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChang(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
     
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            localization.profiletitle,
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            InkWell(
              onTap: widget.toggleThemeMode,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 18, 0),
                child: 
                Icon(CupertinoIcons.moon)
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/profile_image.png',
                        width: 60, height: 60),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(localization.job),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.location,
                                size: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              Text(localization.location,
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: Text(
                localization.summary,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localization.selctedlanguage),
                  CupertinoSlidingSegmentedControl<_Language>(
                    groupValue: _language,
                    children: {
                      _Language.en: Text(
                        localization.enlanguage,
                        style: TextStyle(fontSize: 14),
                      ),
                      _Language.fa: Text(localization.falangage,
                          style: TextStyle(fontSize: 14)),
                    },
                    onValueChanged: (value) {
                      if (value != null) _updateSelectedLanguage(value);
                    },
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    localization.skills,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                direction: Axis.horizontal,
                children: [
                  Skill(
                    type: _SkillType.photoshop,
                    title: 'PhotoShop',
                    imagepath: 'assets/images/app_icon_01.png',
                    shadowColor: Colors.blue,
                    isActive: _skill == _SkillType.photoshop,
                    onTap: () {
                      _updateSelectSkill(_SkillType.photoshop);
                    },
                  ),
                  Skill(
                    type: _SkillType.xd,
                    title: 'Adobe XD',
                    imagepath: 'assets/images/app_icon_05.png',
                    shadowColor: Colors.pink,
                    isActive: _skill == _SkillType.xd,
                    onTap: () {
                      _updateSelectSkill(_SkillType.xd);
                    },
                  ),
                  Skill(
                    type: _SkillType.illusterator,
                    title: 'illusterator',
                    imagepath: 'assets/images/app_icon_04.png',
                    shadowColor: Colors.orange,
                    isActive: _skill == _SkillType.illusterator,
                    onTap: () {
                      _updateSelectSkill(_SkillType.illusterator);
                    },
                  ),
                  Skill(
                      type: _SkillType.affterEffect,
                      title: 'After Effect',
                      imagepath: 'assets/images/app_icon_03.png',
                      shadowColor: Colors.blue.shade900,
                      isActive: _skill == _SkillType.affterEffect,
                      onTap: () {
                        _updateSelectSkill(_SkillType.affterEffect);
                      }),
                  Skill(
                    type: _SkillType.lightRoom,
                    title: 'LightRoom',
                    imagepath: 'assets/images/app_icon_02.png',
                    shadowColor: Colors.blue,
                    isActive: _skill == _SkillType.lightRoom,
                    onTap: () {
                      _updateSelectSkill(_SkillType.lightRoom);
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.personalinformation,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w100),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.email,
                      prefixIcon: Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: localization.password,
                        prefixIcon: Icon(CupertinoIcons.lock)),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(localization.save),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagepath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;

  const Skill({
    Key? key,
    required this.type,
    required this.title,
    required this.imagepath,
    required this.shadowColor,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(16))
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.5),
                        blurRadius: 5,
                      )
                    ])
                  : null,
              child: Image.asset(
                imagepath,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(
              height: 8,
              width: 8,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
