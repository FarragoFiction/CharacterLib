

import 'dart:async';
import "dart:html";
import "package:CreditsLib/CharacterLib.dart";
import 'package:CreditsLib/src/CharacterObject.dart';
import 'package:DollLibCorrect/src/Dolls/Doll.dart';
import 'package:RenderingLib/RendereringLib.dart';

Element content = querySelector("#content");

Future<Null> main() async {
    await Doll.loadFileData();
    List<CreditsObject> credits = await CreditsObject.slurpAllCredits();
    CreditsObject.drawCredits(credits, content);


}