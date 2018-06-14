import 'dart:async';
import 'dart:html';
import 'package:CreditsLib/src/CreditsObject.dart';

class BBBCreator extends CreditsObject
{
  BBBCreator(String name, String dollString) : super(name, dollString);

  @override
  String phrase = "I hope I win!!!";
  @override
  String whatYouDid = "Rawr!!! I made a Big Bad!!!";
  @override
  String website = "http://farragofiction.com/SBURBSimE/BigBadBattle?target=";

  @override
  void syncCredits() {
      creditsContainer.setInnerHtml("");

      DivElement titleLabel = new DivElement()..setInnerHtml("<h3>$name ($title)</h3>");
      titleLabel.classes.add("creditsLine");
      creditsContainer.append(titleLabel);

      DivElement charDollLabel = new DivElement()..text = "Big Bad Creator:";
      charDollLabel.classes.add("creditsLine");

      TextAreaElement charBox = new TextAreaElement();
      charBox.value = toDataString();
      charBox.classes.add("creditsTextArea");

      creditsContainer.append(charDollLabel);
      creditsContainer.append(charBox);

      DivElement labelDoll = new DivElement()..text = "Doll:";
      labelDoll.classes.add("creditsLine");

      TextAreaElement dollBox = new TextAreaElement();
      dollBox.value = doll.toDataBytesX();
      dollBox.classes.add("creditsTextArea");

      creditsContainer.append(labelDoll);
      creditsContainer.append(dollBox);

      DivElement phraseContainer = new DivElement()..setInnerHtml("<b>Phrase:</b> $phrase");
      phraseContainer.classes.add("creditsLine");
      creditsContainer.append(phraseContainer);
      DivElement taskContainer = new DivElement()..setInnerHtml("<b>Big Bad(s) Summary:</b> $whatYouDid");
      taskContainer.classes.add("creditsLine");

      creditsContainer.append(taskContainer);

      if(website != null && website.isNotEmpty) {
          if(!website.contains("http")){
              website = "http://$website";
          }
          AnchorElement websiteContainer = new AnchorElement(href: "$website")
              ..text = "Check Out Big Bads: $website"..target="_blank";
          websiteContainer.classes.add("creditsLine");

          creditsContainer..append(websiteContainer);
      }
  }



  @override
  void makeWebsiteForm(Element container) {
      DivElement subContainer = new DivElement();
      container.append(subContainer);
      LabelElement label = new LabelElement()..text = "Your Link To Your Big Bads (click on your name in one of your entries to find it):";
      label.classes.add("creditsFormLabel");
      websiteElement = new TextInputElement();
      websiteElement.classes.add("creditsFormTextInput");
      websiteElement.onInput.listen((Event e) {
          website = websiteElement.value;
          syncDataBox();
      });
      subContainer.append(label);
      subContainer.append(websiteElement);
  }

  @override
  void makeWhatYouDidForm(Element container) {
      DivElement subContainer = new DivElement();
      container.append(subContainer);
      LabelElement label = new LabelElement()..text = "Brief Description of Big Bad(s):";
      label.classes.add("creditsFormLabel");
      whatYouDidElement = new TextAreaElement();
      whatYouDidElement.classes.add("creditsFormTextArea");
      whatYouDidElement.onInput.listen((Event e) {
          whatYouDid = whatYouDidElement.value;
          syncDataBox();
      });
      subContainer.append(label);
      subContainer.append(whatYouDidElement);
  }

  static Future<List<CreditsObject>> slurpAllCredits() async{
      List<CreditsObject> ret = new List<CreditsObject>();
      List<CreditsObject> aaa = await CreditsObject.slurpCredits("entrants", "Entrant");
      ret.addAll(aaa);

      return ret;
  }

}