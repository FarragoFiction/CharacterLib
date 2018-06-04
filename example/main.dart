

import "dart:html";
import "package:CreditsLib/CharacterLib.dart";

Element content = querySelector("#content");

void main() {
    CreditsObject co = new CreditsObject("SomethingMemorable","");
    co.makeForm(content);
}