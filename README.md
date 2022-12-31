# amplify_trips_planner

A flutter sample application using AWS as a backend.

This application is the end result of the AWS workshops:

- [Build a Flutter Mobile App Using AWS Amplify - Part 1](https://aws.amazon.com/getting-started/hands-on/build-flutter-mobile-app-part-one/)
- [Build a Flutter Mobile App Using AWS Amplify - Part 2](https://aws.amazon.com/getting-started/hands-on/build-flutter-mobile-app-part-two/)

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

For AWS specific Flutter/Amplify information see

- [Get Started](https://docs.amplify.aws/start/q/integration/flutter/)
- [Amplify Libraries](https://docs.amplify.aws/lib/q/platform/flutter/)

## Amplify

Run the following commands to initialise and configure AWS

If you have not yet configure Amplify on the AWS account you intend to deploy to then run the following command:

`amplify configure`

> **Note**: This command only needs to be executed once on each account and evironment

To setup the AWS encironment for this specific application then follow these step:

`amplify init`  
`amplify push`  
`flutter pub get`

To run the application in a simulator use either VS Code or run from command line `flutter run`.

## Notes

The Amplify CLI will modify the folder named `amplify` in the app's root folder, which contains the amplify project and backend details.

It will also add a new dartfile (`amplifyconfiguration.dart`) to `lib/` folder. The app will use this file to know how to reach your provisioned backend resources at runtime.

Finally when you run `amplify init` a file called `team-provider-info.json` in the `amplify` folder.

> Tip: Run the following commands to cleanup environment:
>
> ```
> rm amplify/team-provider-info.json
> git clean -dfx
> ```

> Tip: To cleanup the AWS environment use Cloudformation service the AWS console and delete the root stack.
