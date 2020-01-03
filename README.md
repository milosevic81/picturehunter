# picturehunter

A new Flutter application for &quot;picturehunter&quot; game

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Quickfix for problems on Cataline
If you get an error saying: “dart” can’t be opened because Apple cannot check it for malicious software. The only option I found to remedy this is to globally disable Gatekeeper by typing sudo spctl --master-disable
https://medium.com/@alexandrosbaramilis/setting-up-flutter-on-macos-catalina-d023df8845ae 
'''
sudo spctl --master-disable
'''
