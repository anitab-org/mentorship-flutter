# Mentorship Client

[Mentorship System](https://github.com/anitab-org/mentorship-backend) is an application that allows women in tech to mentor each other, on career development topics, through 1:1 relations for a certain period. This is the flutter client for this project.
written in [Flutter](https://flutter.dev/) framework.

> Work in progress

![demo image](https://i.imgur.com/Xbg7Ty3.png)

### Rationale

AnitaB.org aims to be as inclusive as possible for everyone. It should apply
to user's mobile operating system, too :) That's why we decided to use Flutter
to deliver high-quality app for everybody – Android, iOS, and web users.

From the technical point of view, having one codebase for all platforms will make
adding new featuresand bug fixes much faster.

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

Occasional UI bugs may occur – in this case, please [file an issue](https://github.com/anitab-org/mentorship-flutter/issues/new/choose).

### Overview

The architecture of the app isn't top-notch, but currently it does it job quite well. If you have an idea
on how to improve it, feel free to create an issue.

- App _tries_ to follow Clean Architecture guidelines. Logic is separated into 4 layers:
  - `UI`
  - `BLoC`
  - `Repository`
  - `Service`
- App uses [BLoC pattern](https://bloclibrary.dev/#/coreconcepts) extensively
- To communicate with the API, [Chopper](https://pub.dev/packages/chopper) is used
- To save JWT token, [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) is used
- If you find something in code that looks a bit odd, it might be some useful extension method from `lib/extensions`

#### Web support

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

### Contact us

Feel free to reach out to the maintainers and our community on [AnitaB.org Open Source Zulip](https://anitab-org.zulipchat.com/). If you are interested in participating in discussions related to this project, we have a dedicated stream for this project [#mentorship-system](https://anitab-org.zulipchat.com/#narrow/stream/222534-mentorship-system), where you can ask your doubts and interact with our community.
