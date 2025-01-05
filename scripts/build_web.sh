#!/usr/bin/env bash

flutter clean
flutter pub get
flutter build web --release --dart-define=FLAVOR=product --no-tree-shake-icons
