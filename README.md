![Shakuro HTTPClient](Resources/title_image.png)
<br><br>
# HTTPClient
![Version](https://img.shields.io/badge/version-1.2.2-blue.svg)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
![License MIT](https://img.shields.io/badge/license-MIT-green.svg)

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

HTTPClient is a Swift library designed to abstract away access to Alamofire. The main purpose of the HTTPClient component is to encapsulate endpoints description inside some network abstraction layer to avoid calling Alamofire directly. Enums are used to define enpoints. This allows to make compile-time checks for correct API endpoint accesses.

![](Resources/HTTPClient.png)

## Requirements

- iOS 15.0+
- Xcode 16.0+
- Swift 5.0+

## Installation

### CocoaPods

To integrate HTTPClient into your Xcode project with CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Shakuro.HTTPClient'
```

Then, run the following command:

```bash
$ pod install
```

### Manually

If you prefer not to use CocoaPods, you can integrate Shakuro.HTTPClient simply by copying it to your project.

## Usage

1. Create a couple of endpoints by adopting `HTTPClientAPIEndPoint` protocol.
2. Create responses parsers by adopting `HTTPClientParser` protocol.
3. Create new instance of `HTTPClient` class.
4. Start your HTTP request by calling `.sendRequest`. You should use completions to handle parsed results.

Take a look at the [HTTPClient_Example](https://github.com/shakurocom/HTTPClient/tree/master/HTTPClient_Example) for more info.

## License

Shakuro.HTTPClient is released under the MIT license. [See LICENSE](https://github.com/shakurocom/HTTPClient/blob/master/LICENSE.md) for details.

## Give it a try and reach us

Explore our expertise in <a href="https://shakuro.com/services/native-mobile-development/?utm_source=github&utm_medium=repository&utm_campaign=http-client">Native Mobile Development</a> and <a href="https://shakuro.com/services/ios-dev/?utm_source=github&utm_medium=repository&utm_campaign=http-client">iOS Development</a>.</p>

If you need professional assistance with your mobile or web project, feel free to <a href="https://shakuro.com/get-in-touch/?utm_source=github&utm_medium=repository&utm_campaign=http-client">contact our team</a>
