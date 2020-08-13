# Cross-platform client for Mentorship System

|                                  Branch                                  |                                                        [Travis](https://travis-ci.org/)                                                        |
| :----------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------------------: |
| [develop](https://github.com/anitab-org/mentorship-flutter/tree/develop) | [![Build Status](https://travis-ci.com/anitab-org/mentorship-flutter.svg?branch=develop)](https://travis-ci.com/anitab-org/mentorship-flutter) |


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

## Setup Instructions

In order to setup the project locally, setup instructions have been defined [here](docs/setup-instructions.md)

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
2. [Run local server](https://github.com/anitab-org/mentorship-backend#setup-and-run)

### Contact us

Feel free to reach out to the maintainers and our community on [AnitaB.org Open Source Zulip](https://anitab-org.zulipchat.com/). If you are interested in participating in discussions related to this project, we have a dedicated stream for this project [#mentorship-system](https://anitab-org.zulipchat.com/#narrow/stream/222534-mentorship-system), where you can ask your doubts and interact with our community.
