# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'SwiftModul' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

pod 'RxSwift', '~> 5.0.0'
pod 'RxCocoa', '~> 5.0.0'
pod 'RxDataSources', '~> 4.0.1'
pod 'ReactorKit', '~> 2.0.1'
pod 'Moya/RxSwift', '~> 14.0.0-alpha.1'
pod 'Cache', '~> 5.2.0'
pod 'IQKeyboardManagerSwift', '~> 6.4.0'
pod 'EmptyDataSet-Swift', '~> 4.2.0'
pod 'Kingfisher', '~> 5.7.0'
pod 'SnapKit', '~> 5.0.0'

pod 'SVProgressHUD', '~> 2.2.5'
pod 'MJRefresh', '~> 3.2.0'

swift_42_pod_targets = ['Result','Alamofire','EmptyDataSet-Swift','Cache']
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if swift_42_pod_targets.include?(target.name)
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end

target 'SwiftModulTests' do
  inherit! :search_paths
  pod 'RxBlocking', '~> 5.0.0'
  pod 'RxTest', '~> 5.0.0'
end

end
