//knows how to draw a form to create this.
//knows what dolls are
import "dart:html";
//TODO wire up forms
//TODO slurp from text file
//TODO SERAIALIZE THIS OBJECT
class CreditsObject
{
    String dollString;
    String name;
    String website;
    String phrase;
    String whatYouDid;

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
        makeDollForm(subContainer);
        makeWebsiteForm(subContainer);
        makePhraseForm(subContainer);
        makeWhatYouDidForm(subContainer);
    }

    void makeDataStringForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        TextAreaElement text = new TextAreaElement();
        text.classes.add("creditsFormTextArea");
        text.value = "TODO: SERIALIZE THIS OBJECT";
        subContainer.append(text);
    }

    void makeNameForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Your Name:";
        label.classes.add("creditsFormLabel");
        TextInputElement text = new TextInputElement();
        text.classes.add("creditsFormTextInput");
        text.value = name;
        subContainer.append(label);
        subContainer.append(text);
    }

    //todo validate doll
    void makeDollForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Your Avatar DollString:";
        label.classes.add("creditsFormLabel");
        TextAreaElement text = new TextAreaElement();
        text.classes.add("creditsFormTextInput");
        text.value = dollString;
        subContainer.append(label);
        subContainer.append(text);
    }

    void makeWebsiteForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Your Website(optional):";
        label.classes.add("creditsFormLabel");
        TextInputElement text = new TextInputElement();
        text.classes.add("creditsFormTextInput");
        text.value = website;
        subContainer.append(label);
        subContainer.append(text);
    }

    void makePhraseForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "Associated Phrase (for Walkaround Game):";
        label.classes.add("creditsFormLabel");
        TextAreaElement text = new TextAreaElement();
        text.classes.add("creditsFormTextArea");
        text.value = phrase;
        subContainer.append(label);
        subContainer.append(text);
    }

    void makeWhatYouDidForm(Element container) {
        DivElement subContainer = new DivElement();
        container.append(subContainer);
        LabelElement label = new LabelElement()..text = "What You Did:";
        label.classes.add("creditsFormLabel");
        TextAreaElement text = new TextAreaElement();
        text.classes.add("creditsFormTextArea");
        text.value = whatYouDid;
        subContainer.append(label);
        subContainer.append(text);
    }
}