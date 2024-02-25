# NSBE 2024 Submission: GoMommy
NSBEHacks 2024 Submission. Rongbin Gu, Evan Li, Luthira Abeykoon, Zain Azam

## 💡 Inspiration 🌟
Have you ever been bored out of your mind and wanted to do something? Have you ever found yourself scrolling on Instagram or TikTok and suddenly 4 hours have passed by in the blink of an eye? Have you ever wished that you were more productive? If so, GoMommy is here! 

Inspired by this common dilemma that many youth face in today's world, GoMommy is an intuitive application that detects when it believes you have entered the "doom scrolling" state and encourages you to go outside and do something.

## 😃 What it does 😃
Once GoMommy detects that you have entered the "doom scrolling" state, the program will automatically recommend location suggestions based on the location tags found in the social media content that has been scrolled. We have also taken into consideration the location of the user and the social media content and will give similar location suggestions that are more local to the user. 

To encourage the user to go outside, each time the user travels to the location and posts an image taken from that location to the app, the user will be awarded points which will go towards their total M-Score and ranking on the local leaderboard. With this competition aspect, this will incentive the user to participate and compete with friends and family.

## 🛠️ How we built it ⚙️
**Front-End Development:** We used Flutter and programmed in Dart to build the front-end and user interface experience that the user interacts with. We utilized numerous APIs, such as Google Maps, to provide a seemless end-user experience.

This included a log-in page, user profile, local ranking leaderboard, and a gallery view of all the local landmarks that users can take pictures at to earn points.

**Back-End Development:** We used Python to host our SQLite database and server. This server was responsible for storing all the user registration information and verifiying the identity of the user through the login process. 

## 🚧 Challenges we ran into 🚨
- Setting up the backend for the login portal.
- Setting up the Flutter SDK and various dependencies.
- Stylizing the UI to look aesthetically pleasing.
- Gaining familiarity with Flutter and Dart.
- Integrating Google Maps into our application.

## 🎉 Accomplishes that we're proud of 🎉
Over the short, and tiresome, span of 24 hours, we are proud to have achieved the following:

[X] Successfully program a functioning application that displays the user's outdoor statistics and contributions to the community, AKA M-Score and Mosiac Mastery.
[X] Have a functioning integrated Google Maps within the app and a working picture taker via the camera / gallery.
[X] Seemless home gallery with posts from various community members.
[X] Develop an intuitive application with Flutter that includes login, user profile, and local wonders.
[X] Successfully linked the SQLite server and all the back-end routing.
[X] Consume a total of 0 energy drinks despite the urge.

## 🤓 What we learned 🙌
- How to program in [Dart](https://dart.dev/).
- How to create an application with [Flutter](https://docs.flutter.dev/).
- How to host and run an SQLite server in Python.
- How to use [OpenCV](https://opencv.org/) in Python for an image similarity comparison AI.
- How to set up and use a database.
- How to create a login page and the back-end routing for it.
- How to utilize and understand the [Google Maps API](https://developers.google.com/maps/documentation).
- How to separate independent `.dart` files and link them together.
- How to efficiently resolve merge conflicts.

## 👍How GoMommy helps 👌
**Encourages Outdoor Activities:** With GoMommy, youth are encouraged to stop "doom" scrolling (when someone scrolls endlessly, wasting a tremendous amount of time) and to go outdoors instead. By providing similar nearby location suggestions to the posts seen on their feed, adolescents are incentivized to physically visit these locations instead of viewing them through their screens.

**Promotes Mental Health:** Going and spending time outdoors has proven to improve people's mental health. Mental health is an important and often overlooked aspect of someone's well-being. With GoMommy, adolescents are encouraged to go outdoors and explore their urban environments.

**Building Community Bonds:** As GoMommy marks local checkpoint landmarks, there are opportunities for social interaction among users of the app. This allows for the possibility of social gatherings and activities, ultimately building community bonds and inclusivity.

***In Conclusion:*** GoMommy aims to promote the mental health of youth by encouraging them to go outdoors instead of "doom" scrolling on their phones. This opens up opportunities for social engagement and to strengthen community bonds.

## ✨ What's next for GoMommy ✨
The next steps for GoMommy are to refine the current functionalities of our hack and to improve the quality of user experience. This will most likely require a migration to a better framework such as React.js.

Additionally, we wish to expand our database to include more communities around Canada and the world. We also want to better improve our AI model to recognize whether or not the images are taken in the same area or not.

Lastly, we want to deploy our server and application to mobile app stores to allow users to be able to use GoMommy and to put an end to their "doom scrolling."