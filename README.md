# mentorship_client

Cross-platform client for [Systers&#x27; mentorship system](https://github.com/systers/mentorship-backend).
Created during Christmas.

### Purpose
I really liked Mentorship

### Work status
Basic application flow works, like changing screens and logging in/off. More
advanced functionality coming soon.

**What works?**
- Login and Registration
- Home page
- Profile page (without edit)
- Members page

**What is missing?**
- Edit profile functionality
- Relation page
- Requests page

**What requires improvements**?
- Part responsible for communicating with API. Auto-serialization and deserialization would
be very useful and remove boilerplate from repositories.
- Error handling mechanism. Currently, there's a lot of duplicated boilerplate code in `remote/repositories`
catching errors. I haven't been able to find a good solution currently.
- State management in `screens/register/register_screen.dart` - use BLoC

### Overview
- App *tries* to follow Clean Architecure guidelines. Logic is separated into 4 layers:
    - `UI`
    - `BLoC`
    - `Repository`
    - `Service`
- App uses [BLoC pattern](https://bloclibrary.dev/#/coreconcepts) extensively.
- To communicate with API, [Chopper](https://pub.dev/packages/chopper) is used
- To save JWT token, [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) is used
