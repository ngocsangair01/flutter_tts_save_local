import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';

class TextToSpeechService {
  final FlutterTts flutterTts = FlutterTts();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/output.wav');
  }

  Future<void> speakAndSaveToFile(String text) async {
    final file = await _localFile;

    await flutterTts.setLanguage('vi-VN');
    await flutterTts.setPitch(0.5);
    await flutterTts.setSpeechRate(0.5);

    await flutterTts.synthesizeToFile(text, file.path);
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(UrlSource(file.path));
  }
}
