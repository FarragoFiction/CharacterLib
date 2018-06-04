import 'dart:convert';
import "dart:html";
import "JSONObject.dart";

import 'package:CreditsLib/src/CharacterObject.dart';
class CharacterObject {
    String dollString;
    String name;


    TextAreaElement dataBoxElement;
    TextAreaElement dollStringElement;
    TextInputElement nameElement;

    CharacterObject(String this.name, String this.dollString);

    CharacterObject.fromDataString(String dataString){
        copyFromDataString(dataString);
    }

    void copyFromDataString(String dataString) {
        String rawJson = new String.fromCharCodes(BASE64URL.decode(dataString));
        JSONObject json = new JSONObject.fromJSONString(rawJson);
        copyFromJSON(json);
    }

    void copyFromJSON(JSONObject json) {
        dollString = json["dollString"];
        name = json["name"];
    }

    String toDataString() {
        String ret = toJSON().toString();
        return BASE64URL.encode(ret.codeUnits);
    }

    JSONObject toJSON() {
        JSONObject json = new JSONObject();
        json["dollString"] = dollString;
        json["name"] = name;
        return json;
    }

    void syncFormToObject() {
        nameElement.value = name;
        dollStringElement.value = dollString;
        syncDataBox();
    }

    void makeDataStringForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        dataBoxElement = new TextAreaElement();
        dataBoxElement.classes.add("creditsFormTextArea");
        dataBoxElement.onChange.listen((e) {
            try {
                syncObjectToDataBox();
            }catch(e) {
                print(e);
                window.alert("error parsing data string, $e");
            }
        });
        subContainer.append(dataBoxElement);
    }

    void makeNameForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Your Name:";
        label.classes.add("creditsFormLabel");
        nameElement = new TextInputElement();
        nameElement.classes.add("creditsFormTextInput");
        nameElement.onInput.listen((Event e) {
            name = nameElement.value;
            syncDataBox();
        });
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
        dollStringElement.onInput.listen((Event e) {
            dollString = dollStringElement.value;
            //TODO test this with a doll
            syncDataBox();
        });
        subContainer.append(label);
        subContainer.append(dollStringElement);
    }

    void syncDataBox() {
        dataBoxElement.value = toDataString();
    }

    void syncObjectToDataBox() {
        copyFromDataString(dataBoxElement.value);
        syncFormToObject();
    }

    void makeForm(Element container) {
        DivElement subContainer = new DivElement();
        subContainer.classes.add("creditsFormBox");

        DivElement header = new DivElement()..text = "Charactor Creator";
        header.classes.add("creditsFormHeader");
        subContainer.append(header);

        container.append(subContainer);
        makeDataStringForm(header);
        makeNameForm(subContainer);
        makeDollForm(subContainer);

        syncFormToObject();
    }

}