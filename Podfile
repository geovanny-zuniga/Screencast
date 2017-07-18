# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Screencast' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'SDWebImage', '~>3.8'
  pod 'Moya-ObjectMapper/RxSwift'
  pod 'RxCocoa'
  pod 'SVProgressHUD'
  # Pods for Screencast

  target 'ScreencastTests' do
    inherit! :complete
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'Mockit', '1.3.4'
  end
  

  target 'ScreencastUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
