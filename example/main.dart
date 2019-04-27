

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

    content.appendText("${co1.patience.name}: ${co1.patience.value}");
    content.appendText("${co1.energetic.name}:  ${co1.energetic.value}");
    content.appendText("${co1.idealistic.name}: ${co1.idealistic.value}");
    content.appendText("${co1.curious.name}:  ${co1.curious.value}");
    content.appendText("${co1.loyal.name}:  ${co1.loyal.value}");
    content.appendText("${co1.external.name}:  ${co1.external.value}");


    CreditsObject co = new CreditsObject("SomethingMemorable","");
    co.makeForm(content);

    CharacterObject co2 = new CharacterObject("John Doe","");
    co2.makeForm(content);


}