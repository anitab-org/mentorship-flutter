# Cross-platform client for Mentorship System

| Branch | [Travis](https://travis-ci.org/) 
| :---: | :---: |
| [develop](https://github.com/anitab-org/mentorship-flutter/tree/develop) | [![Build Status](https://travis-ci.com/anitab-org/mentorship-flutter.svg?branch=develop)](https://travis-ci.com/anitab-org/mentorship-flutter) 

Mentorship System is an application that allows women in tech to mentor each other, on career development topics, through 1:1 relations for a certain period of time.

This is the client app for the [Mentorship System backend](https://github.com/anitab-org/mentorship-backend). It's written in the [Flutter](https://flutter.dev) framework.

> Work in progress

<img width="764" alt="App running on Android and iOS devices" src="https://i.imgur.com/Xbg7Ty3.png">

### Purpose

AnitaB.org aims to be as inclusive as possible for everyone. It should apply
to user's mobile operating system, too :) That's why we decided to use Flutter
to deliver a high-quality app for everybody – Android, iOS, and web users.

From the technical point of view, having one codebase for all platforms will make
adding new featuresand bug fixes much faster.

## Contributing 

Please read our [Contributing guidelines](CONTRIBUTING.md), [Code of Conduct](code_of_conduct.md) and [Reporting Guidelines](.github/reporting_guidelines.md).

If you have any questions or simply want to interact with our community, come and join us at out [AnitaB.org Open Source Zulip](https://anitab-org.zulipchat.com/#).
We have a dedicated stream for this project [#mentorship-system](https://anitab-org.zulipchat.com/#narrow/stream/222534-mentorship-system).

### Overview

- App _tries_ to follow Clean Architecture guidelines. Logic is separated into 4 layers:
  - `UI`
  - `BLoC`
  - `Repository`
  - `Service`
- App uses [BLoC pattern](https://bloclibrary.dev/#/coreconcepts) extensively
- To communicate with the API, [Chopper](https://pub.dev/packages/chopper) is used
- To save JWT token, [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) is used
- If you find something in code that looks a bit odd, it might be some useful extension method from `lib/extensions`

#### Setup instructions

1. Install Flutter by following instructions from [flutter.dev](https://flutter.dev).
2. Make sure you install the **Flutter** and **Dart** plugins. The installation instructions above should have instructions on this too.
3. Fork and clone the [mentorship-flutter](https://github.com/anitab-org/mentorship-flutter) repository to your local machine.
4. Open the project on your IDE. Don't be shocked if you see error warnings.
5. Open the terminal and run `flutter channel beta` to switch from stable channel to beta channel of flutter. The beta channel is the one we are using for this project.
6. Some files in this project are generated and because of this, they aren't tracked by git. You need to generate manually by running `flutter pub run build_runner build`.
7. Once done, run the project by running `flutter run` in the terminal to run the app in debug mode. To build a release build you can do the following:

  *for the Android app*

  In the terminal, run the `flutter build apk` command. To build the apk specific to your device arch you can run `flutter build apk --split-per-abi` or `flutter build appbundle --target-platform android-arm,android-arm64,android-x64` (remove arguments which are not required) to get only your arch build. You can read more about this [here](https://flutter.dev/docs/deployment/android)

  *for the iOS app*

  To build a release for IOS app, run `flutter build ios` from the terminal. To learn more on creating build archive, release app on TestFlight or to App Store, click [here](https://flutter.dev/docs/deployment/ios).

8. You are now good to go!🎉

By default, the backend of this project is set to the mentorship-backend dev server. 

### Web support

Flutter for Web is currently at technical preview stage. To test this functionality, I created
a [separate branch](https://github.com/bartekpacia/mentorship-client/tree/web_preview).
I successfully ran this app in Chrome.

[web example here](https://i.imgur.com/zPaWStL.mp4)

> It's neither stable nor works smoothly (yet), but hey, it works.

_Unfortunately_ I was unable to make requests to the [hosted dev server](http://systers-mentorship-dev.eu-central-1.elasticbeanstalk.com/)
because apparently it has CORS disabled.
_Fortunately_, it is at least possible to connect to the server running on localhost :)

To use web version of this app with your local server:

1. Make [these small changes](https://github.com/bartekpacia/mentorship-backend/commit/5c4336fa615b0a480af196954b715410e1a41ac3) to your local webserver
   to enable CORS
2. Run local devserver

### Future?

I'd love Systers to accept this project as one of theirs. I do realize it requires
better documentation and has to be polished a bit, but I really believe these problems
are easy to solve.
My dream? I'll be incredibly happy, for example, if students in next year's Google Code-in will continue its development,
improve it and polish the codebase.

### Contact us

Feel free to reach out to the maintainers and our community on [AnitaB.org Open Source Zulip](https://anitab-org.zulipchat.com/). If you are interested in participating in discussions related to this project, we have a dedicated stream for this project [#mentorship-system](https://anitab-org.zulipchat.com/#narrow/stream/222534-mentorship-system), where you can ask your doubts and interact with our community.
