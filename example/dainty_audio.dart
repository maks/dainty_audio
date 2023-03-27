import 'package:dainty_audio/dainty_audio.dart';

void main(List<String> arguments) {
  print('play wav file:${arguments[0]}');
  final audio = DaintyAudio('native/linux/libminiaudio.so');
  audio.play(arguments[0]);
}
