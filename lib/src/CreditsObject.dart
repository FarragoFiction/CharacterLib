//knows how to draw a form to create this.
//knows what dolls are
import 'dart:convert';
import "dart:html";
import "JSONObject.dart";

import 'package:CreditsLib/src/CharacterObject.dart';
//TODO let them pick between 113 and -113 for wiggler sim stats.
//TODO load from data string
//TODO slurp from text file
class CreditsObject extends CharacterObject
{
    String website;
    String phrase;
    String whatYouDid;

    TextAreaElement phraseElement;
    TextAreaElement whatYouDidElement;
    TextInputElement websiteElement;






    CreditsObject(String name, String dollString):super(name, dollString);

    CreditsObject.fromDataString(String dataString):super("",""){
        copyFromDataString(dataString);
    }
    @override
    void makeForm(Element container) {
        DivElement subContainer = new DivElement();
        subContainer.classes.add("creditsFormBox");

        DivElement header = new DivElement()..text = "Credits Creator";
        header.classes.add("creditsFormHeader");
        subContainer.append(header);

        container.append(subContainer);
        makeDataStringForm(header);
        makeNameForm(subContainer);
        makeWebsiteForm(subContainer);
        makeDollForm(subContainer);
        makePhraseForm(subContainer);
        makeWhatYouDidForm(subContainer);

        syncFormToObject();
    }

    @override
    void copyFromJSON(JSONObject json) {
        super.copyFromJSON(json);
        website = json["website"];
        phrase = json["phrase"];
        whatYouDid = json["whatYouDid"];
    }


    JSONObject toJSON() {
        JSONObject json = super.toJSON();
        json["website"] = website;
        json["phrase"] = phrase;
        json["whatYouDid"] = whatYouDid;
        return json;
    }

    @override
    void syncFormToObject() {
        super.syncFormToObject();
        websiteElement.value = website;
        phraseElement.value = phrase;
        whatYouDidElement.value = whatYouDid;
        syncDataBox();
    }



    void makeWebsiteForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Your Website(optional):";
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

    void makePhraseForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Associated Phrase (for Walkaround Game):";
        label.classes.add("creditsFormLabel");
        phraseElement = new TextAreaElement();
        phraseElement.classes.add("creditsFormTextArea");
        phraseElement.onInput.listen((Event e) {
            phrase = phraseElement.value;
            syncDataBox();
        });
        subContainer.append(label);
        subContainer.append(phraseElement);
    }

    void makeWhatYouDidForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "What You Did:";
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
}