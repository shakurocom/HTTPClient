#
# Be sure to run `pod lib lint Shakuro.iOS_Toolbox.PlaceholderTextView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

    s.name             = 'Shakuro.HTTPClient'
    s.version          = '0.01'
    s.summary          = 'HTTP client for iOS'
    s.homepage         = 'https://github.com/shakurocom/HTTPClient'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.authors          = {'apopov1988' => 'apopov@shakuro.com',
                            'wwwpix' => 'spopov@shakuro.com'}
    s.source           = { :git => 'https://github.com/shakurocom/HTTPClient.git', :tag => s.version }
    s.ios.deployment_target = '13.0'
    s.dependency "Alamofire", "~> 4.5"
    s.framework  = "Foundation"

end
