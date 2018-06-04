

import "dart:html";
import "package:CreditsLib/CharacterLib.dart";
import 'package:CreditsLib/src/CharacterObject.dart';

Element content = querySelector("#content");

void main() {
    CreditsObject co = new CreditsObject("SomethingMemorable","");
    co.makeForm(content);

    CharacterObject co2 = new CharacterObject("John Doe","");
    co2.makeForm(content);

}