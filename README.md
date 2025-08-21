My three AAPS-Garmin-... widgets allow you to administer boluses, enter carbohydrates, and set temporary targets in AAPS when these widgets are accessed from a Garmin watch.
The necessary adjustments in AAPS are currently not available in either the dev or master versions. They are only available in my private AAPS version.
At your own risk, you must copy the Garmin plugin folders and paste them into your own version:

Version 3.3.2:
- https://github.com/swissalpine/AndroidAPS/tree/sport-changes-3.3.2.0/plugins/sync/src/main/kotlin/app/aaps/plugins/sync/garmin
- https://github.com/swissalpine/AndroidAPS/tree/sport-changes-3.3.2.0/plugins/sync/src/androidTest/kotlin/app/aaps/plugins/sync/garmin

Version 3.3.3
- https://github.com/swissalpine/AndroidAPS/tree/3.3.3-mod-alpha/plugins/sync/src/test/kotlin/app/aaps/plugins/sync/garmin
- https://github.com/swissalpine/AndroidAPS/tree/3.3.3-mod-alpha/plugins/sync/src/androidTest/kotlin/app/aaps/plugins/sync/garmin

If AAPS has been modified in this way, the widgets must be built with VisualStudio Code and installed on the watch via sideloading.

Once again: Just because it works for me, I cannot guarantee that it will work for you. If in doubt, it's better to leave this!
