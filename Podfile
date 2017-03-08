# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Pairing' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pairing
pod 'SkyFloatingLabelTextField'
pod 'IQKeyboardManagerSwift'


end
post_install do |installer|
    installer.pods_project.targets.each do |target|
	    if target.name == 'SkyFloatingLabelTextField'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end