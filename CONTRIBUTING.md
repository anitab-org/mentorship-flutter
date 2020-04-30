# Contributing Guidelines

- You can join us on [AnitaB.org Open Source Zulip](https://anitab-org.zulipchat.com/). Each active repo has its own stream to direct questions to (for example #powerup or #portal). Mentorship System stream is [#mentorship-system](https://anitab-org.zulipchat.com/#narrow/stream/222534-mentorship-system).
- Remember that this is an inclusive community, committed to creating a safe, positive environment. See the full [Code of Conduct](http://www.systers.io/code-of-conduct.html).
- Follow our [Commit Message Style Guide](https://github.com/anitab-org/mentorship-android/wiki/Commit-Message-Style-Guide) when you commit your changes.
- Please consider raising an issue before submitting a pull request (PR) to solve a problem that is not present in our [issue tracker](https://github.com/anitab-org/mentorship-flutter/issues). This allows maintainers to first validate the issue you are trying to solve and also reference the PR to a specific issue.
- When developing a new feature, include at least one test when applicable.
- When submitting a PR, please follow [this template](.github/PULL_REQUEST_TEMPLATE.md) (which will probably be already filled up once you create the PR).
- Use only the latest beta version of Flutter.
- When submitting a PR with changes to user interface (e.g.: new screen, ...), please add screenshots to the PR description.
- When you are finished with your work, please squash your commits otherwise we will squash them on your PR (this can help us maintain a clear commit history).
- When creating an issue to report a bug in the project, please follow our [bug_report.md](.github/ISSUE_TEMPLATE/bug_report.md) template.
- Issues labeled as “First Timers Only” are meant for contributors who have not contributed to the project yet. Please choose other issues to contribute to, if you have already contributed to these type of issues.

## General Guidelines

- If you’re just getting started work on an issue labeled “First Timers Only” in any project.
- In an active repository (not an archived one), choose an open issue from the issue list, claim it in the comments, and a maintainer will assign it to you.
- After approval you must make continuous notes on your progress in the issue while working. If there is not at least one comment every 3 days, the maintainer can reassign the issue.
- Create a branch specific to the issue you're working on, so that you send a PR from that branch instead of the base branch on your fork.
- If you’d like to create a new issue, please go through our issue list first (open as well as closed) and make sure the issues you are reporting do not replicate the existing issues.
- Have a short description on what has gone wrong (like a root cause analysis and description of the fix), if that information is not already present in the issue.
- If you have issues on multiple pages, report them separately. Do not combine them into a single issue.

## Code style guidelines

We don't have many of those :)

- Use `dartfmt` ([How to?](https://flutter.dev/docs/development/tools/formatting))
- Set column line width to 100 in your IDE (80 is simply too short). How to? Look below:

  **Android Studio/IntelliJ**:
  <img width="991" alt="Screenshot 2020-04-17 at 12 09 28 AM" src="https://user-images.githubusercontent.com/40357511/79511535-c3883500-803f-11ea-97d4-b9264ed87d74.png">

  **Visual Studio Code**:
  <img width="755" alt="Screenshot 2020-04-30 at 9 47 09 PM" src="https://user-images.githubusercontent.com/40357511/80752748-5a6aec00-8b2c-11ea-9ff8-43d2c34ab564.png">
