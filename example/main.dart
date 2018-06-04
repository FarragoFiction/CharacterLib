

import "dart:html";
import "package:CreditsLib/CreditsLib.dart";

Element content = querySelector("#content");

void main() {
    CreditsObject co = new CreditsObject();
    co.makeForm(content);
}