using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Communications as Comm;

var duration = 0;
var target = 0;
var error = null;
var abfrage = 1; // 1: start, 2: selected, 3: waiting, 4: finished
var reason = "Activity";
var circle, errorCircle = false;
var mgdl = true;
var unitFactor = 1.0;

class MyBehaviorDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
        circle = Gfx.COLOR_BLACK;
    }

    // Detect Menu button input
    function onKey(keyEvent) {
        if( keyEvent.getKey() == 4 ) {
            if( abfrage == 1 ) {
                onMenu();
            } else if( abfrage == 2 ) {
                frageURL();
                error = "Contacting\nAAPS...";
            } else if ( abfrage == 3 ) {
                error = "Waiting for\nAAPS...";
            } else {
                error = "Click SELECT to start!";
                abfrage = 1;
                target = 0;
                duration = 0;
                circle = Gfx.COLOR_BLACK;
            }
            Ui.requestUpdate();
        }
        return false;
    }

    // Same function as onKey()
    function onHold(touchEvent) {
        if( abfrage == 1 ) {
            onMenu();
        } else if( abfrage == 2 ) {
            frageURL();
            error = "Contacting\nAAPS...";
        } else if ( abfrage == 3 ) {
            error = "Waiting for\nAAPS...";
        } else {
            error = "Click SELECT to start!";
            abfrage = 1;
            target = 0;
            duration = 0;
            circle = Gfx.COLOR_BLACK;
        }
        Ui.requestUpdate();
    }

    function onMenu() {
        abfrage = 2;
        var menu = new Ui.Menu();
        var delegate;
        menu.setTitle("Choose TT");
        menu.addItem("Cancel TT", :a);
        if( mgdl == true ) {
            unitFactor = 1.0;
            menu.addItem("80 @ 60m", :b);
            menu.addItem("80 @ 120m", :c);
            menu.addItem("80 @ 180m", :d);
            menu.addItem("120 @ 60m", :e);
            menu.addItem("120 @ 120m", :f);
            menu.addItem("120 @ 180m", :g);
            menu.addItem("140 @ 60m", :h);
            menu.addItem("140 @ 120m", :i);
            menu.addItem("140 @ 180m", :j);
            menu.addItem("140 @ 240m", :k);
            menu.addItem("160 @ 60m", :l);
            menu.addItem("160 @ 120m", :m);
            menu.addItem("160 @ 180m", :n);
            menu.addItem("160 @ 240m", :o);
        } else {
            unitFactor = 0.0555;
            menu.addItem("4.4 @ 60m", :b);
            menu.addItem("4.4 @ 120m", :c);
            menu.addItem("4.4 @ 180m", :d);
            menu.addItem("6.7 @ 60m", :e);
            menu.addItem("6.7 @ 120m", :f);
            menu.addItem("6.7 @ 180m", :g);
            menu.addItem("7.8 @ 60m", :h);
            menu.addItem("7.8 @ 120m", :i);
            menu.addItem("7.8 @ 180m", :j);
            menu.addItem("7.8 @ 240m", :k);
            menu.addItem("8.9 @ 60m", :l);
            menu.addItem("8.9 @ 120m", :m);
            menu.addItem("8.9 @ 180m", :n);
            menu.addItem("8.9 @ 240m", :o);
        }
       
        delegate = new MenuInputDelegate(); // a WatchUi.MenuInputDelegate
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
     }

    //! Aufbereitete URL abfragen
    function frageURL() {
        circle = Gfx.COLOR_WHITE;
        var targetURL = null;
        if( target != null ) {
            targetURL = mgdl == true ? target.format("%.0f") : target.format("%.1f").toFloat();
        }  
        Comm.makeWebRequest(url,{"duration" => duration, "target" => targetURL},{ :method => Comm.HTTP_REQUEST_METHOD_POST, :headers => { "Content-Type" => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON }, :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON}, method(:verarbeiteWerte));
        //Sys.println(targetURL);
        abfrage = 3;
        return true;
     }

     //!  Abfrage auswerten
     function verarbeiteWerte( responseCode, data ) {
        if( responseCode == 200 ) {
            Sys.println(data);
            //error = data.toString();
            error = "Submitted to\n AAPS";
            circle = Gfx.COLOR_GREEN;
        } else {
            error = "Error: " + responseCode.toString();
            circle = Gfx.COLOR_RED;
            errorCircle = true;
        }
        abfrage = 4;
        Ui.requestUpdate();
     }

}

class MenuInputDelegate extends Ui.BehaviorDelegate {

    function initialize() {
       BehaviorDelegate.initialize();
    }

    function onMenuItem(item) {
        circle = Gfx.COLOR_YELLOW;
        if (item == :a) {
            target = null; duration = 0; reason = null;
        } else if (item == :b) {
            target = 80*unitFactor; duration = 60; reason = "Eating Soon";
        } else if (item == :c) {
            target = 80*unitFactor; duration = 120; reason = "Eating Soon";
        } else if (item == :d) {
            target = 80*unitFactor; duration = 180; reason = "Eating Soon";
        } else if (item == :e) {
            target = 120*unitFactor; duration = 60; reason = "Activity";
        } else if (item == :f) {
            target = 120*unitFactor; duration = 120; reason = "Activity";
        } else if (item == :g) {
            target = 120*unitFactor; duration = 180; reason = "Activity";
        } else if (item == :h) {
            target = 140*unitFactor; duration = 60; reason = "Activity";
        } else if (item == :i) {
            target = 140*unitFactor; duration = 120; reason = "Activity";
        } else if (item == :j) {
            target = 140*unitFactor; duration = 180; reason = "Activity";
        } else if (item == :k) {
            target = 140*unitFactor; duration = 240; reason = "Activity";
        } else if (item == :l) {
            target = 160*unitFactor; duration = 60; reason = "Activity";
        } else if (item == :m) {
            target = 160*unitFactor; duration = 120; reason = "Activity";
        } else if (item == :n) {
            target = 160*unitFactor; duration = 180; reason = "Activity";
        } else if (item == :o) {
            target = 160*unitFactor; duration = 240; reason = "Activity";
        }
    }
}

class TempTargetWidgetView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        // AUSGABE
        var addPadding = dc.getWidth() >= 360 ? 15 : 0;
        // Circle
        dc.setColor(circle, circle);
        dc.fillCircle(dc.getWidth() * 0.5, dc.getHeight() * 0.5, dc.getHeight() * 0.5);
        if (errorCircle == false ) {
            dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        } else {
            dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_BLACK);
            errorCircle = false;
        }
        dc.fillCircle(dc.getWidth() * 0.5, dc.getHeight() * 0.5, dc.getHeight() * 0.5 - 5);

        // Titel
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
                dc.getWidth() * 0.5,
                dc.getHeight() * 0.5 + 10 - dc.getFontHeight(Gfx.FONT_MEDIUM) * 0.5 - 40 - 3 - dc.getFontHeight(Gfx.FONT_LARGE) - 3 - addPadding,
                Gfx.FONT_MEDIUM,
                "TempTarget",
                Gfx.TEXT_JUSTIFY_CENTER
        );
        // Icon
        dc.drawBitmap(
            dc.getWidth() * 0.5 - 20,
            dc.getHeight() * 0.5 + 10 - dc.getFontHeight(Gfx.FONT_MEDIUM) * 0.5 - 40 - 3 - addPadding,
            Ui.loadResource(Rez.Drawables.LauncherIcon)
        );
        // Aufgabe
        var text;
        if( target == null ) {
            text = "Cancel TT";
        } else {
            text = mgdl == true ? target.format("%.0f") : target.format("%.1f");
            text += " @ " + duration.toString() + "m";
        }
        var fontSize1 = Gfx.FONT_MEDIUM;
        dc.drawText(
                dc.getWidth() * 0.5,
                dc.getHeight() * 0.5 + 10,
                fontSize1,
                text,
                Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER
        );
        // Anweisung
        var fontSize2 = Gfx.FONT_TINY;
        var anweisung = ( target == 0 ) ? "Click SELECT to start!" : "Push it to\nAAPS?";
        if (error != null ) {
            anweisung = error;
            error = null;
        }
        dc.drawText(
                dc.getWidth() * 0.5,
                dc.getHeight() * 0.5 + 10 + dc.getFontHeight(Gfx.FONT_MEDIUM) * 0.5 + 5,
                fontSize2,
                anweisung,
                Gfx.TEXT_JUSTIFY_CENTER
        );

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}