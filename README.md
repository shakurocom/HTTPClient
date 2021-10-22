![Shakuro HTTPClient](Resources/title_image.png)
<br><br>
# HTTPClient
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
![License MIT](https://img.shields.io/badge/license-MIT-green.svg)

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

HTTPClient is a Swift library designed to abstract away access to Alamofire. The main purpose of the HTTPClient component is to encapsulate endpoints description inside some network abstraction layer to avoid calling Alamofire directly. Enums are used to define enpoints. This allows to make compile-time checks for correct API endpoint accesses.

Image:
Application -> HTTPClient -> Alamofire -> URLSession -> API Server

## Requirements

- iOS 11.0+
- Xcode 11.0+
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

Have a look at the [HTTPClient_Example](https://github.com/shakurocom/HTTPClient/tree/master/HTTPClient_Example)

## License

Shakuro.HTTPClient is released under the MIT license. [See LICENSE](https://github.com/shakurocom/HTTPClient/blob/master/LICENSE.md) for details.

## Give it a try and reach us

Star this tool if you like it, it will help us grow and add new useful things. 
Feel free to reach out and hire our team to develop a mobile or web project for you.

