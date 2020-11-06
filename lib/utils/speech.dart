import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maka/gift/giftDashBoard.dart';
import 'package:maka/screen/FeedPrices.dart';
import 'package:maka/screen/addOrder.dart';
import 'package:maka/screen/addVan.dart';
import 'package:maka/screen/filterScreen.dart';
import 'package:maka/screen/qrcode.dart';
import 'package:maka/screen/scandashboard.dart';
import 'package:maka/screen/vinpage.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

bool hasSpeech = false;
BuildContext speechcontext;
double level = 0.0;
double minSoundLevel = 50000;
double maxSoundLevel = -50000;
String lastWords = "";
String lastError = "";
String lastStatus = "";
String currentLocaleId = "";
List<LocaleName> _localeNames = [];
final SpeechToText speech = SpeechToText();

Future<void> initSpeechState() async {
  bool hasSpeech2 =
      await speech.initialize(onError: errorListener, onStatus: statusListener);
  if (hasSpeech) {
    _localeNames = await speech.locales();

    var systemLocale = await speech.systemLocale();
    currentLocaleId = systemLocale.localeId;
  }

  // if (!mounted) return;

  // setState(() {
  hasSpeech = hasSpeech2;
  // });
}

void stopListening() {
  speech.stop();
  //  setState(() {
  level = 0.0;
  // });
}

void cancelListening() {
  speech.cancel();
  // setState(() {
  level = 0.0;
  //});
}

void startListening() {
  lastWords = "";
  lastError = "";
  speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: 10),
      localeId: 'ar_EG',
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation);
  //  setState(() {});
}

void resultListener(SpeechRecognitionResult result) {
  //  setState(() {
  // BuildContext context;
  lastWords = "${result.recognizedWords}"; //- ${result.finalResult}";
  print(lastWords);
  if (lastWords == 'اضافه طلبيه جديده' || lastWords == 'اضافه طلبيه') {
    Navigator.push(
      speechcontext,
      MaterialPageRoute(
          builder: (context) => AddOrderScreen()), //FilterScreenPage()),
    );
  } else if (lastWords == 'استعلام مشتريات وكيل') {
    Navigator.push(
      speechcontext,
      MaterialPageRoute(
          builder: (context) => FilterScreenPage()), //FilterScreenPage()),
    );
  } else if (lastWords == 'طلبيات وكيل' || lastWords == 'طلبيات الوكيل') {
    Navigator.push(
      speechcontext,
      MaterialPageRoute(builder: (context) => VinPage()), //FilterScreenPage()),
    );
  } else if (lastWords == 'فحص شكاره بالسيريال' ||
      lastWords == 'فحص شكارة بالسيريال') {
    Navigator.push(
      speechcontext,
      MaterialPageRoute(
          builder: (context) => ScanDashBoardScreen()), //FilterScreenPage()),
    );
  }
  // var ss = await scanQR();
  // else if (lastWords == 'فحص الكيو ار كود') {
  //   Navigator.push(
  //     speechcontext,
  //     MaterialPageRoute(
  //         builder: (context) => QrCode(qr: ss)), //FilterScreenPage()),
  //   );
  // }
  else if (lastWords == 'اسعار الاعلاف اليوم') {
    Navigator.push(
      speechcontext,
      MaterialPageRoute(
          builder: (context) => FeedPrices()), //FilterScreenPage()),
    );
  } else if (lastWords == 'الجوائز المقدمه') {
    Navigator.push(
      speechcontext,
      MaterialPageRoute(
          builder: (context) => GiftDashBoardScreen()), //FilterScreenPage()),
    );
  } else if (lastWords == 'اضافه عربيه نقل' || lastWords == 'اضافه عربيه') {
    Navigator.push(
      speechcontext,
      MaterialPageRoute(
          builder: (context) => AddVanScreen()), //FilterScreenPage()),
    );
  }

  //  });
}

void soundLevelListener(double level) {
  minSoundLevel = min(minSoundLevel, level);
  maxSoundLevel = max(maxSoundLevel, level);
  // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
  // setState(() {
  //  this.level = level;
  //  });
}

void errorListener(SpeechRecognitionError error) {
  // print("Received error status: $error, listening: ${speech.isListening}");
  // setState(() {
  lastError = "${error.errorMsg} - ${error.permanent}";
  //  });
}

void statusListener(String status) {
  // print(
  // "Received listener status: $status, listening: ${speech.isListening}");
  //   setState(() {
  lastStatus = "$status";
  //   });
}

_switchLang(selectedVal) {
  //   setState(() {
  currentLocaleId = selectedVal;

  // });
  print(selectedVal);
}
