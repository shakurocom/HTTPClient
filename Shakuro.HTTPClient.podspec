Pod::Spec.new do |s|

    s.name             = 'Shakuro.HTTPClient'
    s.version          = '1.1.5'
    s.summary          = 'HTTP client for iOS'
    s.homepage         = 'https://github.com/shakurocom/HTTPClient'
    s.license          = { :type => "MIT", :file => "LICENSE.md" }
    s.authors          = {'apopov1988' => 'apopov@shakuro.com', 'wwwpix' => 'spopov@shakuro.com'}
    s.source           = { :git => 'https://github.com/shakurocom/HTTPClient.git', :tag => s.version }
    s.swift_versions   = ['5.1', '5.2', '5.3', '5.4', '5.5', '5.6']
    s.source_files     = 'Source/*'
    s.ios.deployment_target = '13.0'

    s.framework        = "Foundation"
    s.dependency       "Alamofire", "~> 5.9.0"
    s.dependency       "Shakuro.CommonTypes", "~> 1.1"
  
end
