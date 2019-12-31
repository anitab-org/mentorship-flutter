# mentorship_client

Cross-platform client for [Systers&#x27; mentorship system](https://github.com/systers/mentorship-backend),
written in [Flutter](https://flutter.dev/).

![demo image](https://i.imgur.com/Xbg7Ty3.png)

### How was it created?

I really liked [Systers](https://github.com/systers)'Mentorship System, wanted to try Flutter and had some free time during Christmas.

### Rationale

Mentorship System aims to be as inclusive as possible for everyone. It should apply
to user's mobile operating system, too :)

### Work status

Basic application flow works, like changing screens and logging in/off. More
advanced functionality coming soon.

**What works?**

- Login and Registration
- Home page (includes updating profile)
- Profile page
- Members page

**What is missing (in comparison to [Mentorship Android](https://github.com/systers/mentorship-android))?**

- Relation page (includes tasks)
- Requests page (includes accepting requests)
- SendRequestScreen exists but sending requests is not implemented
- Changing password

**What requires improvements?**

- Part responsible for communicating with API. Auto-serialization and deserialization would
  be very useful and remove a lot of boilerplate from repositories.
- Error handling mechanism. Currently, there's a lot of duplicated boilerplate code in `remote/repositories`
  catching errors. I haven't been able to find a good solution currently.
- State management in `screens/register/register_screen.dart` - currently lacks BLoC implementation
- Overall code quality. I did my best, but I'm sure one can find many places where certain
  stuff could be written shorter, faster and in a cleanier way.

### Overview

- App _tries_ to follow Clean Architecure guidelines. Logic is separated into 4 layers:
  - `UI`
  - `BLoC`
  - `Repository`
  - `Service`
- App uses [BLoC pattern](https://bloclibrary.dev/#/coreconcepts) extensively
- To communicate with API, [Chopper](https://pub.dev/packages/chopper) is used
- To save JWT token, [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) is used

### Web support

Flutter for Web is currently at technical preview stage. To test this functionality, I created
a [separate branch](https://github.com/bartekpacia/mentorship-client/tree/web_preview).
I successfully ran this app in Chrome.

[web example here](https://i.imgur.com/zPaWStL.mp4)

> It's not stable nor smooth (yet), but hey, it works.

_Unfortunately_ I was unable to make requests to the [hosted dev server](http://systers-mentorship-dev.eu-central-1.elasticbeanstalk.com/)
because apparently it has CORS disabled.
_Fortunately_, it is at least possible to run connect with server running on localhost :)

To use web version of this app with your local server:

1. Make [these small changes](https://github.com/bartekpacia/mentorship-client/tree/web_preview) to your local webserver
   to enable CORS
2. Run local devserver

### Future?

I'd love Systers to accept this project as one of theirs. I do realize it requires
better documentation and improved core architecture (look above), but I really believe
these problems will be solved.
My dream? I'll be incredibly happy, for example, if students in next year's Google Code-in will continue its development,
improve it and polish the codebase.
