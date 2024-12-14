<h1 align="center">
  <img src="https://github.com/exoad/on_the_fly/blob/master/assets/AppIcon.png?raw=true" width="36"> OnTheFly
</h1>
<h3 align="center">
  Effortlessly convert file formats in the background.
</h3>
<p align="center">
<img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/w/exoad/on_the_fly?style=flat-square&logoColor=%23000&labelColor=%23000&color=%23ff2667">
<img alt="GitHub Release" src="https://img.shields.io/github/v/release/exoad/on_the_fly?include_prereleases&sort=date&style=flat-square&labelColor=%23000&color=%23fab916">
<img alt="Windows Builder" src="https://img.shields.io/github/actions/workflow/status/exoad/on_the_fly/windows_builder.yml?style=flat-square">
</p>
<p align="center">
  <strong>OnTheFly</strong> is a desktop app that automates file format conversions in the background. Customize it to monitor multiple folders, process images, handle files matching specific regex patterns, and more!
</p>
<p align="center">
  <img src="https://github.com/exoad/on_the_fly/blob/master/repo/sc1.png?raw=true" alt="App Screenshot" width="78%" />
</p>

## Downloading

Currently, OnTheFly is **not** stable (in active development) for general consumer use, but keep a watch in the [Releases Tab](https://github.com/exoad/on_the_fly/releases)!

## Building

As previously stated, OnTheFly is **not** stable and is in active development, so expect bugs, undocumented actions, etc.. Additionally, there currently is only support for Windows. Building for any other platforms will produce undefined behavior.

**In order to build, you must have the Flutter SDK downloaded: https://docs.flutter.dev/get-started/install**

1. Clone the repository (`git clone https://github.com/exoad/on_the_fly.git`)
2. Enter the root directory of the repository
3. Download all project dependencies: `flutter pub get`
4. Run the respective Flutter build command for Windows: `flutter build windows --release` (the `--release` flag is used for maximal optimization)
5. The built artifact can be located in the generated folder `./build/windows/Runner/Release`


## Supported Formats

**Currently there are only implementations for image formats, but more mediums will be added!**

### Input
- `webp`
- `png`
- `jpg`
- `tiff`
- `gif`
- `bmp`
- `ico`

### Output
- `png`
- `jpg`
- `tiff`
- `gif`
- `bmp`

## Translations + Contributing

This app is currently stable for English, with additional works for Simplified Chinese (中国大陆).

All of the internationalization can be found in [`./lib/i18n/*.yaml`](https://github.com/search?q=repo%3Aexoad%2Fon_the_fly+path%3A%2F%5Elib%5C%2Fi18n%5C%2F%2F++language%3AYAML&type=code&l=YAML). If you spot a mistake in the strings or want to make a suggestion, please include it in a pull request! Thank you very much for your contributions :)

## Acknowledgements

Here are some of the tools and libraries that make this app possible and greatly simplified the development process.

### [gskinner/flutter_animate](https://github.com/gskinner/flutter_animate)

For simplifying the animation creation process and enhancing the app's overall smoothness.

### [flutter](https://flutter.dev/)

A well built framework that is the backbone of this app.

### [brendan-duncan/image](https://github.com/brendan-duncan/image)

For a versatile cross-platform image IO library for Dart.

### [unDraw](https://undraw.co/)

Providing amazing illustrations within the UI.

### Contributors

<a href="https://github.com/exoad/on_the_fly/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=exoad/on_the_fly" />
</a>
