## 💡 Inspiration 🌟

Have you ever found yourself scrolling on Instagram or TikTok and suddenly 4 hours have passed by in the blink of an eye? Have you wished you spent more time outside, discovering your community? Mosaic can help you with both.

Inspired by this common dilemma that many youth face in today's world, Mosaic is an intuitive social media application that discourages the "doom scrolling" state and encourages you to go outside and connect .

## 😃 What it does 😃

Mosaic lets you share where you've been and encourages others nearby to match your photo at the same location. Not only does it share the classic social media appeal of sharing your adventures, it heavily emphasizes having others go on your adventures too.

To encourage the user to go outside, each time the user travels to the location and posts an image taken from that location to the app, the user will be awarded points which will go towards their total M-Score and ranking on the local leaderboard. With this competition aspect, this will incentivize the user to participate and compete with friends, family, and community members. The app also promotes local culture by shining spotlights on lesser-known cultural locations. For lesser-privileged communities in urban areas, this can greatly strengthen the bonds between community members and will hopefully foster an environment of mutual support.

## 🛠️ How we built it ⚙️

**Front-End Development:** We used Flutter and programmed in Dart to build the front-end and user interface experience that the user interacts with. We utilized numerous APIs, such as Google Maps, to provide a seamless end-user experience.

This included a log-in page, user profile, local ranking leaderboard, and a gallery view of all the local landmarks that users can take pictures to earn points.

**Back-End Development:** We used Python to host our SQLite database and server. This server was responsible for storing all the user registration information and verifying the identity of the user through the login process. It also kept track of all new posts and the leaderboard.

## 🚧 Challenges we ran into 🚨

- Setting up the backend for the login portal - many of us didn't have much backend experience.
- Setting up the Flutter SDK and various dependencies.
- Gaining familiarity with Flutter and Dart - it was our first time using them!
- Integrating Google Maps into our application.

## 🎉 Accomplishes that we're proud of 🎉

Over the short, and tiresome, span of 24 hours, we are proud to have achieved the following:

* Successfully program a functioning application that displays the user's outdoor statistics and contributions to the community.
* Integrated Google Maps within the app and a working picture taker/uploader via the camera/gallery.
* Created a seamless home gallery with posts from various community members.
* Developed an intuitive application with Flutter that includes logins and user profiles.
* Successfully linked the SQLite server and all the back-end routing.
* Consumed a total of 0 energy drinks despite the urge.

## 🤓 What we learned 🙌

- How to program in [Dart](https://dart.dev/).
- How to create an application with [Flutter](https://docs.flutter.dev/).
- How to host and run an SQLite server in Python.
- How to set up and use a database.
- How to create a login page and the back-end routing for it.
- How to utilize and understand the [Google Maps API](https://developers.google.com/maps/documentation).
- How to convert latitude and longitude measurements into kilometer proximity metrics.
- How to separate independent `.dart` files and link them together.
- How to efficiently resolve merge conflicts.

## 👍How Mosaic helps 👌

**Encourages Outdoor Activities:** With Mosaic, youth are encouraged to stop "doom" scrolling (when someone scrolls endlessly, wasting a tremendous amount of time) and to go outdoors instead. By providing similar nearby location suggestions to the posts seen on their feed, adolescents are incentivized to physically visit these locations instead of viewing them through their screens.

**Promotes Mental Health:** Going and spending time outdoors has proven to improve people's mental health. With Mosaic, adolescents are encouraged to go outdoors and explore their urban environments.

**Building Community Bonds:** As Mosaic marks local checkpoint landmarks, there are opportunities for social interaction among users of the app. This allows for the possibility of social gatherings and activities, ultimately building community bonds and inclusivity. While modern urban communities can sometimes be separated and cold, Mosaic hopes to bring the youth in these places together.

## ✨ What's next for Mosaic ✨

The next steps for Mosaic are to refine the current functionalities of our hack and to improve the quality of user experience. This will most likely require a migration to a different framework such as React.js - but it was fun to learn Flutter too.

Additionally, we wish to expand our database to include more communities around Canada and the world, and to improve our scoring algorithms, most likely with more sophisticated AI models, to more effectively encourage participation.

Lastly, we want to deploy our server and application to mobile app stores to allow users to be able to use Mosaic and to put an end to their "doom scrolling."
