# Tour Management App
 
## An application for operating and managing campus tours developed using **Flutter**
***
### Included: </br>
<ul>
 <li> Cross-platform Material UI Theme</li>
 <li> State management using <b>flutter_bloc</b> </li>
 <li> Online database using <b>Cloud Firestore</b> provided by <b>Firebase</b></li>
 <li> Push notifications, real-time update application </li>
 <li> Integration to native camera library for device camera access </li>
</ul>
***
### Features: </br>
<ol>
 <li> Role-based authentication (Login, register, password management)</li>
 <li> Viewing checkpoints plans, create & edit plans with special access</li>
 <li> Viewing groups of participants, managing people</li>
 <li> Chat channel, with real-time updates on messages</li>
 <li> Customed personal profile for users</li>
 <li> Push notifications on certain events</li>
***
### Setting up environment (for all platform to follow)
1. **Dart** </br>
To download the Dark SDK, first head to the website [DarkSDK Download](https://dart.dev/get-dart) and follow the instruction for installing the Dart SDK for your specific platform </br>
***Note:*** From **Flutter 1.21**, the Flutter SDK has Dart SDK inclcuded in the setup, so we can skip this step entirely
***
2. **Flutter** </br>
To download the Flutter SDK, first head to the website [FlutterSDK Download](https://flutter.dev/docs/get-started/install) and follow the instruction for installing the Flutter SDK for your specific platform </br>
***Note:*** This SDK setup link also provide the setting up for the simulator devices used for running the application, in case you don't have a MAC, skip the **XCode (iOS) setup** </br>
Then, set up an editor for working or running the project, following the steps from [Flutter Editor Setup](https://flutter.dev/docs/get-started/editor?tab=androidstudio) with either **Android Studio** or **VSCode** </br>
***
3. **Firebase** </br>
To set up a console for Firebase project, first head to the website [Firebase Console](https://console.firebase.google.com/u/0/?hl=vi&pli=1), you will need a Google account for setting up the console. </br>
Set up the project name, then set up the services via the dashboard: </br>
* Choose *Authentication* from the dashboard, navigate to *Sign-in methods*, **Enable** the *Email/Password* method
* Choose *Firebase Database* from the dashboard, create a database via the instruction in **Test mode**, create 4 collections as followed: *users, chatRoom, feedbacks, checkpoints* with any random first document, the latter will be added by the application itself.
* Choose to *Add app* via the dashboard and follow the instructions given for each specific platform (Android and iOS app).
***
### Running the application
1. After cloning the application from git, please replace the setup files from Firebase to your accordance (.plist and .json files for adding to apps).
2. Launch any editor that have been set up with all plugins installed. 
3. From the editor, launch a simulator device (either iOS or Android)
4. From the editor, launch *Terminal* (for MAC) or *Command line* (for Windows), run **flutter clean** in which the path of the application is located, this is to clean up all the builds and runnable.
5. You can either choose to debug the app from the editor toolbars or type in **flutter run** to run on any running devices
6. If you want to create a runnable **.apk** file which you can install on a physical device, type in **flutter build apk** and the editor will take care of the rest.
7. The application when running in *debug* or *profile* mode will have a **Hot Reload** function for any changes to be made immediately, however, that function will not work in *release* mode or built .apk since they are running final product and not subceptible to changes.
