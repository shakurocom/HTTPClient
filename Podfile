source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'

use_frameworks!

workspace 'HTTPClient'

target 'HTTPClient_Framework' do
    project 'HTTPClient_Framework.xcodeproj'
    pod 'Shakuro.CommonTypes', '1.9.5'
    pod 'Alamofire', '5.10.2'
end

target 'HTTPClient_Example' do
    project 'HTTPClient_Example.xcodeproj'
    pod 'SwiftLint', '0.57.1'
    pod 'Shakuro.CommonTypes', '1.9.5'
    pod 'Alamofire', '5.10.2'
end

post_install do |installer|

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end

end
