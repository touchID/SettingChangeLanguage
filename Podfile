#source 'https://cdn.cocoapods.org/'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
inhibit_all_warnings!

target 'SettingChangeLanguage' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Masonry'
# 网络库

#pod 'IQKeyboardManager'#, '~> 6.4.0'
#pod 'FDFullscreenPopGesture'
pod 'PrintBeautifulLog'
#pod 'SDWebImage'#, '5.0.6'
#pod 'YYCache'
pod 'YYModel'
#pod 'SDCycleScrollView'
#pod 'TYCyclePagerView'#, '~> 1.2.0'
#pod 'YJProgressHUD'
#pod 'YBImageBrowser/Video'
##.//视频功能需添加
#pod 'ShortMediaCache'
#,:git => 'https://github.com/dangercheng/ShortMediaCache.git'
#pod 'VIMediaCache'
#pod 'BaiduMobStatCodeless' # 无埋点SDK
pod 'Reachability'
pod 'SVProgressHUD', '~> 2.3.1'#, '~> 2.3.1' #2.2.5

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
  
