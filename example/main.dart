

import 'dart:async';
import "dart:html";
import "package:CreditsLib/CharacterLib.dart";
import 'package:CreditsLib/src/CharacterObject.dart';
import 'package:DollLibCorrect/src/Dolls/Doll.dart';
import 'package:RenderingLib/RendereringLib.dart';

Element content = querySelector("#content");
//oh god //
Future<Null> main() async{
    await Doll.loadFileData();

    BBBCreator co1 = new BBBCreator("BBCreator","");
    co1.makeForm(content);

    CreditsObject co = new CreditsObject("SomethingMemorable","");
    co.makeForm(content);

    CharacterObject co2 = new CharacterObject("John Doe","");
    co2.makeForm(content);

}