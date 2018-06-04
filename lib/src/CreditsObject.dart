//knows how to draw a form to create this.
//knows what dolls are
import 'dart:convert';
import "dart:html";
import "JSONObject.dart";
//TODO wire up forms
//TODO load from data string
//TODO slurp from text file
class CreditsObject
{
    String dollString;
    String name;
    String website;
    String phrase;
    String whatYouDid;

    TextAreaElement dataBoxElement;
    TextAreaElement dollStringElement;
    TextAreaElement phraseElement;
    TextAreaElement whatYouDidElement;
    TextInputElement nameElement;
    TextInputElement websiteElement;


    CreditsObject({String this.name: "SomethingUnique" , String this.dollString, String this.website, String this.phrase: "I helped!!!", String this.whatYouDid: "I did a thing!!!"});

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

    CreditsObject.fromDataString(String dataString){
        copyFromDataString(dataString);
    }

    void copyFromDataString(String dataString) {
        String rawJson = new String.fromCharCodes(BASE64URL.decode(dataString));
        JSONObject json = new JSONObject();
        copyFromJSON(json);
    }

    void copyFromJSON(JSONObject json) {
        dollString = json["dollString"];
        name = json["name"];
        website = json["website"];
        phrase = json["phrase"];
        whatYouDid = json["whatYouDid"];
    }

    String toDataString() {
        String ret = toJSON().toString();
        return BASE64URL.encode(ret.codeUnits);
    }

    JSONObject toJSON() {
        JSONObject json = new JSONObject();
        json["dollString"] = dollString;
        json["name"] = name;
        json["website"] = website;
        json["phrase"] = phrase;
        json["whatYouDid"] = whatYouDid;
        return json;
    }

    void syncDataBox() {
        dataBoxElement.value = toDataString();
    }

    void syncObjectToDataBox() {
        copyFromDataString(dataBoxElement.value);
    }

    void syncFormToObject() {
        nameElement.value = name;
        websiteElement.value = website;
        phraseElement.value = phrase;
        whatYouDidElement.value = whatYouDid;
        dollStringElement.value = dollString;
        syncDataBox();
    }

    void makeDataStringForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        dataBoxElement = new TextAreaElement();
        dataBoxElement.classes.add("creditsFormTextArea");
        subContainer.append(dataBoxElement);
    }

    void makeNameForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Your Name:";
        label.classes.add("creditsFormLabel");
        nameElement = new TextInputElement();
        nameElement.classes.add("creditsFormTextInput");
        subContainer.append(label);
        subContainer.append(nameElement);
    }

    //todo validate doll
    void makeDollForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Your Avatar DollString:";
        label.classes.add("creditsFormLabel");
        dollStringElement = new TextAreaElement();
        dollStringElement.classes.add("creditsFormTextArea");
        subContainer.append(label);
        subContainer.append(dollStringElement);
    }

    void makeWebsiteForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Your Website(optional):";
        label.classes.add("creditsFormLabel");
        websiteElement = new TextInputElement();
        websiteElement.classes.add("creditsFormTextInput");
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
        subContainer.append(label);
        subContainer.append(whatYouDidElement);
    }
}