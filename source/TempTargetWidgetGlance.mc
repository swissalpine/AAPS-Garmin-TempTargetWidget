using Toybox.Application as App;
using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Timer as Timer;
using Toybox.Communications as Comm;
using Toybox.Time as Time;

(:glance)
class MyGlanceView extends Ui.GlanceView
{

    function initialize() {
        GlanceView.initialize();
    }


    function onUpdate(dc) {

        var width = dc.getWidth();
        var height = dc.getHeight();

        dc.setColor(Gfx.COLOR_BLACK,Gfx.COLOR_BLACK);
        dc.clear();
        // Zeichne Balken
        dc.setPenWidth(3);
        // Hintergrund
        dc.setColor(Gfx.COLOR_DK_GRAY,Gfx.COLOR_TRANSPARENT);
        dc.drawLine(0, height/2, width, height/2);

        // Textausgabe
        dc.setColor(Gfx.COLOR_WHITE,Gfx.COLOR_TRANSPARENT);
        dc.drawText(0, height/2 - dc.getFontHeight(Gfx.FONT_GLANCE) - 5, Gfx.FONT_GLANCE, "TEMPORARY TARGET", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(0, height/2 + 5, Gfx.FONT_GLANCE, "to AAPS", Gfx.TEXT_JUSTIFY_LEFT);
    }

}