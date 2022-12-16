# S'Not A Problem Final Project Dev Repo 
## Cloned from CSCI 32000-02 Fall 2022
Our project for an upper level, undergraduate User Interface design class. I am quite proud of our project, and some improvements may follow in the future here. *-Patrick*

## Patrick May, Addison Walling, Aymane Lachhab

<!-- Welcome to our final project repo! We are the developers for the **Inevitable Solutions** team. We are creating a way to optimize and condense shopping in-person at a big box store. Log here to track our (descent) into madness: -->

# Purpose
Our application is called MapMyShopping. The goal of this app is to assist users in enhancing the efficency of their shopping. MapMyShopping helps better locate your items by giving aisle numbers, this will help prevent snaking up and down aisles trying to find that one item. 

In our research we found that many people would often struggle to find items in big box stores. The signs the stores give do not provide enough direction and detail that many shoppers need. 

MapMyShopping is the solution for this allowing users to find exactly which aisle their item is in and then quickly get to the next aisle without all the searching.

# Developer Bios
*Patrick May* is currently a junior computer science student at The College of Wooster. He is from Pittsburg, PA and in his free time, enjoys various video games, music, and fitness, in addition to the general nerdy hobbies that all computer scientists seem to have. In the world of computer science, he enjoys competetive programming, software engineering, and computer security. Find out more [here](https://github.com/patrick-may) 😎

Addison Walling: Class of 2024 Computer Science Major at The College of Wooster. Formally from the city of Boston his hobbies include getting lost in stores looking for items. Is scared that MapMyShopping will take away his hobby and will have nothing left to do on weekends. 😨

Aymane Lachhab: Junior majoring in Neuroscience with a double minor in biology and computer science. He is from Rabat, Morocco and his hobbies range from video games to reading passing by sports. MapMyShopping sucked my soul.

# Building the Project

For more detailed instructions in how to get started, please reference `"docs/Setup & Build Instructions.md"`.

## Quickstart 
- Install Flutter, which can be found, with documented steps found [here](https://docs.flutter.dev/get-started/install)
- Setup Flutter to a specific development environment (VSCode, Android Studio, etc) by following next steps within Flutter start guide
- In your chosed development environment, navigate to the flutter project, `flutter-final-01/map-my-shopping/` contained within this repo
- **Important:** You may need to run `flutter pub get` on a terminal within our project to get the additional dependencies we used
- Within your development environment, choose how you want to view our flutter project. **We designed this primarily on an android emulator**, which involves installing the general android SDK. It may work on other platforms, but we have NOT tested them, nor can we guarantee functionality.
- Using your preferred code editor, navigate to `snot-a-problem-final-project/flutter-final-01/map-my-shopping/lib/main.dart
- Run `main.dart`. The application should launch in your chosen emulator/webview/attached device/etc.
- As this was a UI class, the app should hopefully be intuitive, although for more detailed instructions about each page and running the app, refer to the file `"docs/Usage Instructions"`.


# Time Log of Development Progress
- 9/25/2022: Issues are made to track user stories for the project. A very limited number of tasks per user story are made as well.
- 9/29/2022: Significant Repo cleaning and adding info for Research/Needfinding Assignment
- 10/17/2022: Usability testing documentation created
- 10/17/2022 EOD: Figma prototype for the usability testing added
- 10/23/2022: `/usability-study-01` added with notes from usability study
- 10/26/2022: `/flutter-final-01` added as folder that holds flutter implementation of final project
- 10/30/2022: some fundamental refactoring of `lib/` folder for project, split into `app/` and `ui/` subfolders
- 10/30/2022: simple routed added, and a flutter form of `faker` was added to include bogus data
- 11/06/2022: bottom navigation bar WIP
- 11/13/2022: 75% of the way towards a functioning search bar page, just some weird quirks to figure out (in hindsight, some major quirks)
- 11/13/2022: `list_item.dart` created, to be the widget container for list items in the search page and in the shopping list page
- 11/20-26/2022: various significant changes 🤷‍♂️
- 11/28/2022: Presentation Given, lots of good feedback recieved!
- 12/1/2022 onward: Various final tweaks