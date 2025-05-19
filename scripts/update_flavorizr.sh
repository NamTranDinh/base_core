#!/bin/sh

cd ..
flutter pub run flutter_flavorizr -p android:androidManifest,assets:download,assets:extract,android:buildGradle,android:dummyAssets,android:icons,flutter:flavors,flutter:targets,ios:xcconfig,ios:buildTargets,ios:schema,ios:dummyAssets,ios:icons,ios:plist,ios:launchScreen,assets:clean