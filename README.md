## Welcome! <img src="https://user-images.githubusercontent.com/3911039/113623796-c025f900-9656-11eb-929e-17d3c22357ff.gif" width="30px" alt="wave gif">



### ℹ️ What is this project?
This project will try to help you understand the basics behind SwiftUI and Combine (+ some Widgets and HealthKit!).
It contains different branches that will incrementally add functionality, from the most basic state, to the addition of widgets and more configuration.



### 🧐 Why did I started this project?
I love Apple Fitness workout views but sadly (as today), those same views are not offered as widgets for the home screen. So I am replicating those ones, and adding the widget-capability myself. By open sourcing it, I thought It could be a great example for other developers to see how to deploy a basic structure of SwiftUI-Combine + Widgets and HealthKit with clear and concise code.
Feel free to open PR or issues to improve it!



### 🏋️‍♀️ The workout widgets
More and more views will be included. As of today, workout views are implemented and a example widget is already done:

<img src="https://user-images.githubusercontent.com/3911039/117643229-14555900-b180-11eb-8389-c8ef10d5d19c.gif" alt="App demo" width="250"/>



### 🧠 High level design
The main app struct `Workout_CompanionApp`, contains a `WorkoutManager` which is responsible of:
- Gathering `HealthKit` authorization
- Gathering `HealthKit` data
- Providing that data through `@Publisher`s into anyone observing

The main app inits this `WorkoutManager` as a `@StateObject` property that will be injected via `environmentObject` into the main view tree.

The main view will use specific publishers from the `WorkoutManager` to feed specific views/widgets down the UI tree. This publishers will emit specifc `ViewModels` for each view that needs to consume them.

<img width="1113" alt="Screenshot 2021-05-10 at 11 43 02" src="https://user-images.githubusercontent.com/3911039/117647482-eaeafc00-b184-11eb-8de2-b984425525c4.png">


### How to connect with me?
- 🙌🏻 Say _hi_ and add me on my [LinkedIn](https://www.linkedin.com/in/marioeguiluzalebicto/)
- 👾 Dare to challenge me @ Fifa or Warzone!
- 🐦 Connect on my [Twitter](https://twitter.com/marioeguiluz)



---
> _"It was a bright cold day in April, and the clocks were striking thirteen."_
---
