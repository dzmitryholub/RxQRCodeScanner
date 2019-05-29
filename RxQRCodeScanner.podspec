Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "RxQRCodeScanner"
s.summary = "Simple reactive QR code scanner"
s.requires_arc = true
s.version = "1.0.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Dmitry" => "dimon011093@gmail.com" }
s.homepage = "https://github.com/dmitry1993/RxQRCodeScanner"
s.source = { :git => "https://github.com/dmitry1993/RxQRCodeScanner.git", 
             :tag => "#{s.version}" }

s.framework = "UIKit"
s.framework = "AVFoundation"
s.dependency 'RxSwift', '~> 5.0.0'
s.dependency 'RxCocoa', '~> 5.0.0'
s.swift_version = "5.0"
s.source_files = "RxQRCodeScanner/**/*.{swift}"
s.resources = "RxQRCodeScanner/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

end
