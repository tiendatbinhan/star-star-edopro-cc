# Contributing to ☆Star-Star☆ for EDOPro

Thank you for your interest in contributing to the "☆Star-Star☆" archetype custom cards repository for EDOPro. Whether you're fixing card text, adding new cards, or enhancing functionality, your contributions help improve the quality and gameplay experience for everyone.

## 1. Contributing

Due to my extensive internship work, I may not be able to push updates frequently, but I will review contributions regularly. Please follow these guidelines to help maintain the quality and consistency of the repository:

- **PSCT Compliance**: Any cards added must adhere to the standard, current Problem-Solving Card Text (PSCT). You can find guidance on PSCT formatting on [Yugipedia](https://yugipedia.com/wiki/Problem-Solving_Card_Text). If unsure about the exact behavior of any card, please discuss with Omegaplayer00 (recommended) or reach out to me directly.
- **Game Rules Compliance**: Some cards might have effects incompatible with existing game mechanics. Please adjust these effects to function within EDOPro’s framework while preserving their original intent.
- **Passcode Format**: Each card’s passcode (represented as the `id` in the `.cdb` file) should be formatted as `95XXXXXXX`, with seven randomly chosen digits following `95`.
- **Testing**: Make sure to thoroughly test new or modified cards locally before submitting.

## 2. Pull Request Process

To streamline the integration process, please adhere to the following steps when creating a pull request:

1. **Branching**: Submit all changes to the `experiment` branch. This branch is reviewed weekly, and approved cards will be merged into the `main` branch. **Do not push directly to the `main` branch.**
2. **Code Modifications**:
   - If you add new helper functions or constants, make sure to include them in `helper_function.lua` or `constant.lua` respectively.
   - Reuse functions for similar card behaviors whenever possible, with slight variations if necessary.
3. **Testing and Approval**: Ensure that all new cards or changes are tested in-game before submitting. Only pull requests with passing tests and consistent formatting will be approved.

## 3. Code of Conduct

### Pledge

In the interest of promoting an inclusive and constructive environment, we, as contributors, commit to making participation in this project a respectful and harassment-free experience for everyone.

### Standards

Examples of behavior that contributes to a positive environment for our
community include:

* Demonstrating empathy and kindness toward other people
* Being respectful of differing opinions, viewpoints, and experiences
* Giving and gracefully accepting constructive feedback
* Accepting responsibility and apologizing to those affected by our mistakes,
  and learning from the experience
* Focusing on what is best not just for us as individuals, but for the overall
  community

Examples of unacceptable behavior include:

* The use of sexualized language or imagery, and sexual attention or advances of
  any kind
* Trolling, insulting or derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or email address,
  without their explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

### Responsibilities

As maintainers, I am committed to:
- Reviewing contributions as time permits, providing feedback and constructive criticism where necessary.
- Enforcing this Code of Conduct consistently, fairly, and with appropriate discretion.

### Scope

This Code of Conduct applies to all aspects of collaboration within the project, including GitHub discussions, pull requests, and direct communications between contributors.

### Enforcement

Instances of unacceptable behavior may be reported for review. Depending on the severity or frequency of violations, I may take appropriate corrective action, up to and including temporary or permanent bans from contributing to this repository, future EDOPro custom card projects I initiate, or any EDOPro projects in which I am involved.

### Attribution

This Code of Conduct is adapted from the [Contributor Covenant](https://www.contributor-covenant.org), version 2.1.
