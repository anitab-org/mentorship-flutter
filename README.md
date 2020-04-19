# Mentorship Client

Cross-platform client for [Systers&#x27; mentorship system](https://github.com/systers/mentorship-backend),
written in [Flutter](https://flutter.dev/).
test travis
![demo image](https://i.imgur.com/Xbg7Ty3.png)

### How was it created?

I really liked [Systers](https://github.com/systers)' Mentorship System, wanted to try Flutter and had some free time during Christmas.

### Rationale

Mentorship System aims to be as inclusive as possible for everyone. It should apply
to user's mobile operating system, too :)

### Work status

Application is a high-fidelity copy of the Android version. It has all essential
features implemented, though some may not work perfectly.

**What works?**
Almost everything.

- Login and Registration
- Home page
- Profile page
- Relation Page
- Members page
- Changing password

**What is missing? (in comparison to [Mentorship Android](https://github.com/systers/mentorship-android))**

- RelationPage: updating `availableToMentor` and `needsMentoring` status doesn't work
- About screen is basically About dialog. It's very simple, more info should be added.

Occasional UI bugs may occur – in this case, please create an issue.

### Overview

- App _tries_ to follow Clean Architecure guidelines. Logic is separated into 4 layers:
  - `UI`
  - `BLoC`
  - `Repository`
  - `Service`
- App uses [BLoC pattern](https://bloclibrary.dev/#/coreconcepts) extensively
- To communicate with API, [Chopper](https://pub.dev/packages/chopper) is used
- To save JWT token, [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) is used
- If you find something in code that looks a bit odd, it might be some useful extension method from `lib/extensions`

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
