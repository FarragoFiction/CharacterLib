//knows how to draw a form to create this.
//knows what dolls are
import 'dart:async';
import 'dart:convert';
import "dart:html";
import "JSONObject.dart";

import 'package:CreditsLib/src/CharacterObject.dart';
import 'package:DollLibCorrect/DollRenderer.dart';
//TODO let them pick between 113 and -113 for wiggler sim stats.
//TODO load from data string
//TODO slurp from text file
class CreditsObject extends CharacterObject
{
    String website = "";
    String phrase = "I helped!!!";
    String whatYouDid = "I did a thing!!!";
    //not stored in json at all. just deal with it.
    String title;

    TextAreaElement phraseElement;
    TextAreaElement whatYouDidElement;
    TextInputElement websiteElement;

    Element creditsContainer;


    CreditsObject(String name, String dollString):super(name, dollString);

    CreditsObject.fromDataString(String dataString):super("",""){
        print("trying to make a new Credits Object from $dataString");
        copyFromDataString(dataString);
    }
    @override
    void makeForm(Element container) {
        makeBox(container);
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
        makeStatForm(subContainer);

        syncFormToObject();
    }

    @override
    void syncViewerToDoll() {
        if(canvasViewer != null) {
            canvasViewer.setInnerHtml("");
            CanvasElement canvas = new CanvasElement(width: cardWidth, height: cardHeight);
            canvasViewer.append(canvas);
            makeViewerBorder(canvas);
            makeViewerDoll(canvas);
            makeViewerText(canvas);
        }
        syncCredits();
    }

    void makeBox(Element container) {
        TableElement table = new TableElement();
        container.append(table);
        TableRowElement tr = new TableRowElement();
        table.append(tr);

        TableCellElement td1 = new TableCellElement();
        tr.append(td1);
        TableCellElement td2 = new TableCellElement();
        tr.append(td2);
        makeViewer(td1);
        makeCredits(td2);
    }

    void makeCredits(Element container) {
        creditsContainer = new DivElement();
        container.append(creditsContainer);
        creditsContainer.classes.add("creditsBox");
        syncCredits();
    }

    void syncCredits() {
        creditsContainer.setInnerHtml("");

        AnchorElement titleLabel = new AnchorElement(href: "?target=${name.replaceAll(' ', '_')}")..setInnerHtml("<h3>$name ($title)</h3>");
        titleLabel.classes.add("creditsLine");
        creditsContainer.append(titleLabel);

        DivElement charDollLabel = new DivElement()..text = "Character:";
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
        DivElement taskContainer = new DivElement()..setInnerHtml("<b>Acomplishment:</b> $whatYouDid");
        taskContainer.classes.add("creditsLine");

        creditsContainer.append(taskContainer);

        if(website != null && website.isNotEmpty) {
            if(!website.contains("http")){
                website = "http://$website";
            }
            AnchorElement websiteContainer = new AnchorElement(href: "$website")
                ..text = "Check Out My Website: $website"..target="_blank";
            websiteContainer.classes.add("creditsLine");

            creditsContainer..append(websiteContainer);
        }
    }

    @override
    void copyFromJSON(JSONObject json) {
       // print("copying from json");
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
       // print(phrase.codeUnits);
        return json;
    }

    String validate() {
        String ret = null;
        ret = super.validate();
        if(ret != null) return ret;
        ret = CharacterObject.validateString(website);
        if(ret != null) return ret;
        ret = CharacterObject.validateString(whatYouDid);
        if(ret != null) return ret;
        ret = CharacterObject.validateString(phrase);
        if(ret != null) return ret;
        return "Actually, nevermind,  it looks fine???";
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

    static Future<List<CreditsObject>> slurpAllCredits() async{
        List<CreditsObject> ret = new List<CreditsObject>();
        List<CreditsObject> aaa = await slurpCredits("aaa", "A Rank");
        List<CreditsObject> wranglers = await slurpCredits("wranglers", "Wrangler");
        List<CreditsObject> pioneers = await slurpCredits("pioneers", "Pioneer");
        List<CreditsObject> patrons = await slurpCredits("patrons", "Patron");
        List<CreditsObject> credits = await slurpCredits("credits", "Buckaroo");
        ret.addAll(aaa);
        ret.addAll(wranglers);
        ret.addAll(pioneers);
        ret.addAll(patrons);
        ret.addAll(credits);
        return ret;
    }

    static List<CreditsObject> filterBy(List<CreditsObject> entries, List<String> doop) {
        for(String s in doop) {
            print("s is $s");
            entries = new List.from(entries.where((CreditsObject e) {
                return e.name.contains(s) || e.whatYouDid.contains(s);
            }));
        }
        return entries ;
    }


    static Future<List<CreditsObject>> slurpCredits(String filename, String title) async{
        print("loading $filename");
        String url = "Credits/${filename}.txt";
        if(!window.location.href.contains("localhost")) url = "http://farragofiction.com/CreditsSource/${filename}.txt";
        String data = await Loader.getResource(url);
        List<String> creditsFromFile = data.split(new RegExp("\n|\r"));
        List<CreditsObject> ret = new List<CreditsObject>();
        for(String s in creditsFromFile) {
            //print("processing $s");
            try {
                if (s.isNotEmpty) ret.add(
                    new CreditsObject.fromDataString(s)..title = title);
            }catch(e) {
                print("error parsing $s");
            }
        }

        return ret;
    }

    static Future<Null> drawCredits(List<CreditsObject> credits, Element container) async{
        for (CreditsObject c in credits) {
            await drawOneBox(c, container);
        }
    }

    static Future<Null> drawOneBox(CreditsObject c, Element container) async {
        c.makeBox(container);
        await new Future.delayed(const Duration(milliseconds : 500));

    }
}