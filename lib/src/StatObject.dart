import 'dart:convert';
import 'dart:html';
import 'package:CreditsLib/src/CharacterObject.dart';
import 'package:CreditsLib/src/JSONObject.dart';

class StatObject {
    static int MAXVALUE = 113;
    static int MINVALUE = -113;

    static String PATIENCE = "patience";
    static String ENERGETIC = "energetic";
    static String IDEALISTIC = "idealistic";
    static String CURIOUS = "curious";
    static String LOYAL = "loyal";
    static String EXTERNAL = "external";
    static String IMPATIENCE = "impatience";
    static String CALM = "calm";
    static String REALISTIC = "realistic";
    static String ACCEPTING = "accepting";
    static String FREE = "free-spirited";
    static String INTERNAL = "internal";

    String namePositive;
    String nameNegative;
    InputElement rangeElement;
    CharacterObject owner;

    int value;

    String get name {
        if(value >= 0) return namePositive;
        return nameNegative;
    }

    StatObject(CharacterObject this.owner, String this.namePositive, String this.nameNegative, int this.value);

    void makeForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement labelNeg = new LabelElement()..text = nameNegative;

        rangeElement = new InputElement();
        rangeElement.type = "range";
        rangeElement.min = "$MINVALUE";
        rangeElement.max = "$MAXVALUE";
        rangeElement.classes.add("creditsFormRangeInput");

        rangeElement.onInput.listen((Event e) {
            value = int.parse(rangeElement.value);
            this.owner.syncDataBox();
        });

        LabelElement labelPos = new LabelElement()..text = namePositive;
        subContainer.append(labelNeg);
        subContainer.append(rangeElement);
        subContainer.append(labelPos);

    }

    void syncFormToObject() {
        if(rangeElement != null) rangeElement.value = "$value";
    }

    void copyFromJSON(JSONObject json) {
        value = int.parse(json["value"]);
        namePositive = json["name"];
    }

    StatObject.fromDataString(String dataString){
        copyFromDataString(dataString);
    }

    StatObject.fromJSONObject(JSONObject json){
        copyFromJSON(json);
    }

    void copyFromDataString(String dataString) {
        String rawJson = new String.fromCharCodes(BASE64URL.decode(dataString));
        JSONObject json = new JSONObject.fromJSONString(rawJson);
        copyFromJSON(json);
    }

    String toDataString() {
        String ret = toJSON().toString();
        return BASE64URL.encode(ret.codeUnits);
    }

    JSONObject toJSON() {
        JSONObject json = new JSONObject();
        json["namePositive"] = namePositive;
        json["nameNegative"] = nameNegative;
        json["name"] = name;
        json["value"] = "$value";
        return json;
    }
}