Elbe is a Flutter UI toolkit and collection of tools that runs on all platforms.

## Description

Elbe is designed to provide a collection of reusable UI components and utilities for building beautiful and responsive Flutter applications. It is based on Flutter, a popular cross-platform framework for building mobile, web, and desktop applications.

an online demo/documentation can be accessed here: [**DEMO**](https://robbb.in/elbe)

## Features

- Reusable UI components (minimalist and customizable)
- Responsive design
- Cross-platform compatibility
- state management `bit`
- theming
- routing
- logging
- Open source and free to use

## Installation

To use Elbe in your Flutter project, follow these steps:

1. Open your project's `pubspec.yaml` file.
2. Add the following line to the `dependencies` section:

   ```yaml
   dependencies:
     elbe: ^<latest version>
   ```

3. Run `flutter pub get` to fetch the package.

## Usage

Import the Elbe package in your Flutter project

##### 1. define a router

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => YourHomePage();
    )]);
```

##### 2. define the app

define and call your app within your `main.dart` file

```dart
import 'package:elbe/elbe.dart';

void main() async => runApp(const MyApp());

final router = GoRouter(
    routes: [GoRoute(
      path: '/',
      builder: (context, _) => const YourPage())]);

class YourApp extends StatelessWidget {
  const YourApp({super.key});

  @override
  Widget build(BuildContext context) =>
    ElbeApp(router: router);
}
```

you are now ready to build your app with _elbe_
<br><br>

# guide

## state management (bit)

elbe defines its own state management system. This is partly based on the popular `bloc` library, but aims to limit the amount of boilerplate code needed.

### how it works

- a `bit` can be defined by the user
  - it includes both:
    - a value
    - the logic that can be carried out on this state (`BitControl`)
  - the bit is injected into the `BuildContext` and can be accessed within the subtree
  - the bit will update its dependent children, once its value changes
  - the value of a bit can be in one of three states:
    - `loading`: this signifies that no data is currently available
    - `error`: the logic ran into an error that requires user interaction
      - examples would be: _connection lost, access denied_
    - `data`: the value of the bit reflects usable data.
      - _NOTE:_ In contrast to the `bloc` library, differentiating between different kinds of data has
        to be done outside of the core state management
        - the easiest option is to include flags within the value

### usage

##### 1. defining a bit

note that there are different types of `BitControl`s. These allow for more complex behaviours. For the sake of simplicity, we will stick to the basic `MapMsgBitControl`.

use the `worker` to carry out complex (async) operations. The bit will be initiated in the `loading` state, and the worker is called.

```dart
class CounterBit extends MapMsgBitControl<int> {
  static const builder = MapMsgBitBuilder<int, CounterBit>.make;

  CounterBit({int? initial})
      : super.worker((_) async => initial ?? 0);

  /// add one to the current state. this internally calles init
  /// and thus updates the UI
  addOne() =>
    state.whenOrNull(
      onError: (_) => this.emit(0) //reset on error,
      onData: (v) => this.emit(v + 1));
}
```

##### 2. injecting bit

once you have defined your bit, you need to integrate it into the build tree.
Do this by using the `BitProvider` widget within the tree

```dart
  BitProvider(
    create: (_) => CounterBit(initial: 42),
    child: ...)
```

##### 3. using the bit

now you are ready to use your bit (within the subtree) 🎉. The `builder` function of the bit will return a Widget that automatically updates your UI when the value of the `bit` changes

```dart
ConfigBit.builder(
  onLoading: (bit, loading) => CircularProgressIndicator.adaptive(),
  onError: (bit, error) => Text("Error: $error"),
  onData: (bit, value) =>
    Button.minor(
      label: "current: $value",
      onTap: () => bit.addOne()
    )
),
```

## Info

### conflicts

some **elbe** widgets are (intentionally) named the same as corresponding widgets provided by Flutter. If you want
to use the Flutter version, use one of the following aliases:

- `Icon` -> `WIcon`
- `Text` -> `WText`
- `Border` -> `WBorder`
