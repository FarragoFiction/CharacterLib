import 'dart:async';
import 'dart:convert';
import "dart:html";
import "JSONObject.dart";
import "package:RenderingLib/RendereringLib.dart";
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:CreditsLib/src/StatObject.dart';
class CharacterObject {
    static String labelPattern = ":___ ";

    int cardWidth = 400;
    int cardHeight = 525;
    String dollString;
    String name;
    Doll doll;


    TextAreaElement dataBoxElement;
    TextAreaElement dollStringElement;
    TextInputElement nameElement;
    List<StatObject> stats = new List<StatObject>();

    Element canvasViewer;


    CharacterObject(String this.name, String this.dollString) {
        initializeStats();
        doll = Doll.randomDollOfType(1);
    }

    int get seed {
        if(doll != null) {
            return doll.seed;
        }else if(name != null && name.isNotEmpty){
            return name.codeUnitAt(0);
        }else {
            print("can't do random, just doing seed of 13");
            return 13;
        }
    }

    CharacterObject.fromDataString(String dataString){
        copyFromDataString(dataString);
    }



    void initializeStats() {
        stats.clear();
        Random rand = new Random(seed);
        stats.add(new StatObject(this, StatObject.PATIENCE,StatObject.IMPATIENCE,rand.nextIntRange(StatObject.MINVALUE, StatObject.MAXVALUE)));
        stats.add(new StatObject(this, StatObject.ENERGETIC,StatObject.CALM,rand.nextIntRange(StatObject.MINVALUE, StatObject.MAXVALUE)));
        stats.add(new StatObject(this, StatObject.IDEALISTIC,StatObject.REALISTIC,rand.nextIntRange(StatObject.MINVALUE, StatObject.MAXVALUE)));
        stats.add(new StatObject(this, StatObject.CURIOUS,StatObject.ACCEPTING,rand.nextIntRange(StatObject.MINVALUE, StatObject.MAXVALUE)));
        stats.add(new StatObject(this, StatObject.LOYAL,StatObject.FREE,rand.nextIntRange(StatObject.MINVALUE, StatObject.MAXVALUE)));
        stats.add(new StatObject(this, StatObject.EXTERNAL,StatObject.INTERNAL,rand.nextIntRange(StatObject.MINVALUE, StatObject.MAXVALUE)));
    }

    void copyFromDataString(String dataString) {
        print("dataString is $dataString");
        List<String> parts = dataString.split("$labelPattern");
        print("parts are $parts");
        if(parts.length > 1) {
            dataString = parts[1];
        }
        String rawJson = new String.fromCharCodes(BASE64URL.decode(dataString));
        JSONObject json = new JSONObject.fromJSONString(rawJson);
        copyFromJSON(json);
    }

    void copyFromJSON(JSONObject json) {
        dollString = json["dollString"];
        doll = Doll.loadSpecificDoll(dollString);
        name = json["name"];
        String idontevenKnow = json["stats"];
        loadStatsFromJSON(idontevenKnow);
    }

    void loadStatsFromJSON(String idontevenKnow) {
        if(idontevenKnow == null) return;
        List<dynamic> what = JSON.decode(idontevenKnow);
        //print("what json is $what");
        for(dynamic d in what) {
            //print("dynamic json thing is  $d");
            JSONObject j = new JSONObject();
            j.json = d;
            StatObject s = new StatObject.fromJSONObject(j);
            //don't replace, just overwrite
            for(StatObject s2 in stats) {
                print("comparing s ${s.namePositive} and s2 of ${s2.namePositive}");
                if(s.namePositive == s2.namePositive) {
                    print("setting one of my stats to ${s.value}");
                    s2.value = s.value;
                    break;
                }
            }
        }
    }

    String toDataString() {
        try {
            String ret = toJSON().toString();
            return "$name$labelPattern${BASE64URL.encode(ret.codeUnits)}";
        }catch(e) {
            print(e);
            window.alert("Error Saving Data. Are there any special characters in there? ${validate()} $e");
        }
    }

    String validate() {
        String ret = null;
        ret = validateString(name);
        if(ret != null) return ret;
        return null;
    }

    //make sure is base 64 encoded
    static String validateString(String s) {
        for(int i in s.codeUnits) {
            if(i>255) {
                return "What character is ${new String.fromCharCode(i)}  ???  (if it looks normal, it could be your word processor fucked it up. try deleting it and retyping it right in the form)";
            }
        }
        return null;
    }

    JSONObject toJSON() {
        JSONObject json = new JSONObject();
        if(doll != null) dollString = doll.toDataBytesX();
        json["dollString"] = dollString;
        json["name"] = name;

        List<JSONObject> jsonArray = new List<JSONObject>();
        for(StatObject s in stats) {
            //print("Saving ${p.name}");
            jsonArray.add(s.toJSON());
        }
        json["stats"] = jsonArray.toString();


        return json;
    }

    void syncFormToObject() {
        nameElement.value = name;
        if(doll != null) dollString = doll.toDataBytesX();
        dollStringElement.value = dollString;

        for(StatObject s in stats) {
            s.syncFormToObject();
        }
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
            try {
                doll = Doll.loadSpecificDoll(dollString);
                syncDataBox();
            }catch(e) {
                window.alert("Error loading doll. Are you sure it was a valid DollSim URL?");
            }
        });
        subContainer.append(label);
        subContainer.append(dollStringElement);
    }

    void syncDataBox() {
        dataBoxElement.value = toDataString();
        syncViewerToDoll();
    }

    void syncObjectToDataBox() {
        print("going to sync object to data box");
        copyFromDataString(dataBoxElement.value);
        print("going to sync form to data box");
        if(doll != null && doll.toDataBytesX() != dollString) {
            doll = Doll.loadSpecificDoll(dollString);
        }
        syncViewerToDoll();
        syncFormToObject();
    }

    void makeForm(Element container) {
        makeViewer(container);
        DivElement subContainer = new DivElement();
        subContainer.classes.add("creditsFormBox");

        DivElement header = new DivElement()..text = "Charactor Creator";
        header.classes.add("creditsFormHeader");
        subContainer.append(header);

        container.append(subContainer);
        makeDataStringForm(header);
        makeNameForm(subContainer);
        makeDollForm(subContainer);
        makeStatForm(subContainer);


        syncFormToObject();
    }

    void makeViewer(Element subContainer) {
        canvasViewer = new DivElement();
        canvasViewer.classes.add("charViewer");
        subContainer.append(canvasViewer);
        CanvasElement canvas = new CanvasElement(width: cardWidth, height: cardHeight);
        canvasViewer.append(canvas);
        makeViewerBorder(canvas);
        makeViewerDoll(canvas);
        makeViewerText(canvas);
    }

    void syncViewerToDoll() {
        if(canvasViewer != null) {
            canvasViewer.setInnerHtml("");
            CanvasElement canvas = new CanvasElement(width: cardWidth, height: cardHeight);
            canvasViewer.append(canvas);
            makeViewerBorder(canvas);
            makeViewerDoll(canvas);
            makeViewerText(canvas);
        }
    }

    void makeViewerBorder(CanvasElement canvas) {
        canvas.context2D.fillStyle = "#616161";
        canvas.context2D.strokeStyle = "#3b3b3b";
        int lineWidth = 6;
        canvas.context2D.lineWidth = lineWidth;
        canvas.context2D.fillRect(0, 0, canvas.width, canvas.height);
        canvas.context2D.strokeRect(lineWidth-2,lineWidth-2,canvas.width-(lineWidth+2), canvas.height-(lineWidth+2));
    }

    void makeViewerText(CanvasElement canvas) {
        canvas.context2D.fillStyle = "#ffffff";
        canvas.context2D.strokeStyle = "#ffffff";
        int fontSize = 24;
        int currentY = (300+fontSize*2).ceil();

        canvas.context2D.font = "bold ${fontSize}pt Courier New";
        Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, name, "Courier New", 20, currentY, fontSize, cardWidth-50, fontSize);
        fontSize = 18;
        canvas.context2D.font = "bold ${fontSize}pt Courier New";
        currentY += (fontSize*2).round();
        for(StatObject s in stats) {
            canvas.context2D.fillText("${s.name}:",20,currentY);
            canvas.context2D.fillText("${s.value.abs()}",350-fontSize,currentY);

            currentY += (fontSize*1.2).round();
        }
    }

    Future<Null> makeViewerDoll(CanvasElement canvas) async{
        CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
        await DollRenderer.drawDoll(dollCanvas, doll);
        int buffer = 12;
        CanvasElement allocatedSpace = new CanvasElement(width: cardWidth-buffer, height: 300);
        Renderer.drawToFitCentered(allocatedSpace, dollCanvas);
        canvas.context2D.drawImage(allocatedSpace,buffer, buffer);
    }

    void makeStatForm(Element subContainer) {
        DivElement statDiv = new DivElement()..text = "Stats";
        subContainer.append(statDiv);
        for(StatObject s in stats) {
            s.makeForm(statDiv);
        }
    }

}