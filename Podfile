# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'GithubUsers' do

	pod 'Kingfisher'
	pod 'Alamofire'
	pod 'Toast-Swift' 

	post_install do |installer|
	  installer.pods_project.targets.each do |target|
	    if target.name == 'Kingfisher' || target.name == 'Alamofire' || target.name == 'Toast-Swift'
	      target.build_configurations.each do |config|
	        config.build_settings['SWIFT_VERSION'] = '4.2'
	      end
	    end
	  end
end

end
