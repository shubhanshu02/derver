// Copyright 2016 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';
import 'dart:io';

import 'package:charcode/charcode.dart';
import 'package:cli_pkg/cli_pkg.dart' as pkg;
import 'package:grinder/grinder.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';

void main(List<String> args) {
  pkg.humanName.value = 'derver';
  pkg.botName.value = 'Sass Bot';

  pkg.executables.value = {'derver': 'bin/server.dart'};
  pkg.debianRepo.value = 'sass/homebrew-sass';
  pkg.standaloneName.value = 'derver';
  pkg.gpgFingerprint.value = "4BF9 9CCE DBD4 C6CF 1F41  2C6A 4A78 2902 AFE6 5DC9";
  pkg.gpgPassphrase.value = "derver";
  pkg.debianControlPath.value = 'control';
  pkg.gpgPrivateKey.value = File("privateKey").existsSync() ? File("privateKey").readAsStringSync(): "";
  pkg.addAllTasks();
  grind(args);
}

@DefaultTask('Apply dartfmt to all Dart source files')
void format() {
  // pkg.update();
}
