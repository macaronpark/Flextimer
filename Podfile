# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'


target 'Flextimer' do
  # Comment the next line if you don't want to use dynamic frameworks
  source 'https://github.com/cocoapods/specs.git'
  use_frameworks!

  # Pods for Flextimer
  pod 'RealmSwift'
  pod 'SnapKit', '~> 5.0.0'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Then' 
  pod 'Firebase/Analytics'
    
  target 'Widget' do
    pod 'RealmSwift'
  end
 
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
         target.build_configurations.each do |config|
            if config.name == 'Debug'
               config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
            end
         end
      end
   end
end
