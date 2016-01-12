Pod::Spec.new do |s|

s.name         = 'YUKit'
s.module_name  = 'YUKit'
s.version      = ‘1.0.3’
s.summary      = 'YUKit for iOS.(objective-c 、c++）'
s.homepage     = 'https://github.com/c6357/YUKit'
s.license      = "MIT"
s.authors      = { "BruceYu" => "c6357@outlook.com" }
s.platform     = :ios, '7.0'
#s.ios.deployment_target = '7.0'
s.source       = {:git => 'https://github.com/c6357/YUKit.git', :tag => s.version}

#s.source_files = 'YUKit/**/*.{h,m,cpp,mm,c}'
#s.public_header_files = 'YUKit/**/*.{h}'

#s.public_header_files = 'YUKit/YUKitHeader.h'
s.source_files = 'YUKit/YUKitHeader.h'

s.requires_arc = true


pch_AF = <<-EOS
#ifdef DEBUG
#define TBMB_DEBUG
#endif
EOS
s.prefix_header_contents = pch_AF


#s.default_subspec = 'All'
 #s.subspec 'All' do |ss|
   #ss.ios.dependency 'YUKit/foundation'
   #ss.ios.dependency 'YUKit/uikit'
   #ss.ios.dependency 'YUKit/base'
   #ss.ios.dependency 'YUKit/services'
   #ss.ios.dependency 'YUKit'
  #end



#---header
s.subspec 'header' do |ss|
    ss.source_files  = 'YUKit/*'
end


#---foundation
s.subspec 'foundation' do |ss|

    ss.subspec 'lib' do |sss|
        sss.ios.dependency 'YUKit/header'
        sss.ios.dependency 'YUKit/services/Reachability'
        sss.source_files = 'YUKit/foundation/lib/**/*.{h,m,cpp,mm,c}'
    end

    ss.subspec 'category' do |sss|
        sss.ios.dependency 'YUKit/header'
        sss.ios.dependency 'YUKit/foundation/lib'
        sss.source_files = 'YUKit/foundation/category/**/*.{h,m,cpp,mm,c}'
    end

    ss.source_files = 'YUKit/foundation/YU_Core.{h}'
end


#---uikit
s.subspec 'uikit' do |ss|
    ss.subspec 'lib' do |sss|
        sss.ios.dependency 'YUKit/header'
        sss.ios.dependency 'YUKit/foundation'
        sss.source_files = 'YUKit/uikit/lib/**/*.{h,m,cpp,mm,c}'
    end

    ss.subspec 'category' do |sss|
      	sss.ios.dependency 'YUKit/header'
       	sss.ios.dependency 'YUKit/foundation'
	#sss.ios.dependency 'BlocksKit/UIKit'
      	sss.source_files = 'YUKit/uikit/category/**/*.{h,m,cpp,mm,c}'
    end

    ss.source_files = 'YUKit/uikit/YU_UI.{h}'
end


#---services
s.subspec 'services' do |ss|
    ss.subspec 'NSJson' do |sss|
        sss.source_files = 'YUKit/services/NSJson/**/*.{h,m,cpp,mm,c}'
    end

    ss.subspec 'Reachability' do |sss|
        sss.requires_arc            = false
        sss.source_files = 'YUKit/services/Reachability/**/*.{h,m,cpp,mm,c}'
    end

#ss.ios.dependency 'YUKit/services/NSJson'
#ss.ios.dependency 'YUKit/header'
#ss.ios.dependency 'YUKit/foundation'
#ss.ios.dependency 'YUKit/uikit'


#ss.ios.vendored_frameworks = 'YUKit/framework/YUDBFramework.framework'
#ss.source_files = 'YUKit/services/YU_*.{h,m}'
end



#---base
s.subspec 'base' do |ss|
    ss.subspec 'NavigationController' do |sss|
        sss.source_files = 'YUKit/base/NavigationController/**/*.{h,m,cpp,mm,c}'
    end

    ss.subspec 'ViewController' do |sss|
        sss.ios.dependency 'YUKit/header'
        sss.ios.dependency 'YUKit/uikit'
        sss.ios.dependency 'YUKit/foundation'
        sss.source_files = 'YUKit/base/ViewController/**/*.{h,m,cpp,mm,c}'
    end


    ss.subspec 'TableView' do |sss|
        sss.ios.dependency 'YUKit/header'
        sss.ios.dependency 'YUKit/uikit'
        sss.ios.dependency 'YUKit/foundation'
        sss.ios.dependency 'YUKit/base/ViewController'
        sss.source_files = 'YUKit/base/TableView/**/*.{h,m,cpp,mm,c}'
    end


    ss.subspec 'View' do |sss|
        sss.source_files = 'YUKit/base/View/**/*.{h,m,cpp,mm,c}'
    end


    ss.subspec 'ViewModel' do |sss|
        sss.source_files = 'YUKit/base/ViewModel/**/*.{h,m,cpp,mm,c}'
    end

    ss.source_files = 'YUKit/base/YU_Base.{h}'
end



s.ios.vendored_frameworks = 'YUKit/framework/YUDBFramework.framework'

s.frameworks = 'UIKit', 'QuartzCore', 'Foundation'
s.library = 'sqlite3'


s.dependency 'MJRefresh', '~> 2.2.0'
s.dependency 'Masonry', '~> 0.6.2'
s.dependency 'AFNetworking' , '~>2.5.4'
s.dependency 'BlocksKit', '~> 2.2.5'



end
