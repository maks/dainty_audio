import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'libminiaudio_generated_bindings.dart';

class DaintyAudio {
  final String libPath;

  libminiaudio get _miniaudio => libminiaudio(DynamicLibrary.open(libPath));

  DaintyAudio([this.libPath = 'libminiaudio.so']);

  Future<void> play(String filename) async {
    if (!File(filename).existsSync()) {
      throw Exception('invalid audio file:$filename');
    }

    final engine = calloc<ma_engine>();

    final result = _miniaudio.ma_engine_init(nullptr, engine);

    if (result != ma_result.MA_SUCCESS) {
      print('Failed to initialize audio engine.');
    }

    final cPtrFilename = filename.toNativeUtf8().cast<Char>();
    _miniaudio.ma_engine_play_sound(engine, cPtrFilename, nullptr);

    print('Press Enter to quit...');
    stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

    _miniaudio.ma_engine_uninit(engine);
  }
}
