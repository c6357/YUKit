Pod::Spec.new do |s|

s.name         = 'YUKit'
s.module_name  = 'YUKit'
s.version      = '2.0.0'
s.summary      = 'YUKit for iOS.(objective-c 、c++）'
s.homepage     = 'https://github.com/c6357/YUKit'
s.license      = "MIT"
s.authors      = { "BruceYu" => "c6357@outlook.com" }
s.platform     = :ios, '7.0'
s.source       = {:git => 'https://github.com/c6357/YUKit.git', :tag => s.version}
s.source_files = 'YUKitSample/YUKit/YUKit/YUKitHeader.h'
s.requires_arc = true


pch_AF = <<-EOS
#ifdef DEBUG
#define TBMB_DEBUG
#endif
EOS
s.prefix_header_contents = pch_AF


#———header
s.subspec 'header' do |ss|
    ss.source_files  = 'YUKitSample/YUKit/YUKit/*.{h}'
end

#ios.dependency
#import

#———foundation
s.subspec 'foundation' do |ss|
    ss.subspec 'lib' do |sss|
        sss.ios.dependency 'YUKit/header'
        sss.source_files = 'YUKitSample/YUKit/YUKit/foundation/lib/**/*.{h,m,cpp,mm,c}'
    end

    ss.subspec 'category' do |sss|
        sss.ios.dependency 'YUKit/header'
        sss.ios.dependency 'YUKit/foundation/lib'
        sss.source_files = 'YUKitSample/YUKit/YUKit/foundation/category/**/*.{h,m,cpp,mm,c}'
    end

    ss.source_files = 'YUKitSample/YUKit/YUKit/foundation/YU_Foundation.{h}'
end


#———uikit
s.subspec 'uikit' do |ss|
	ss.subspec 'lib' do |sss|
		sss.ios.dependency 'YUKit/header'
		sss.ios.dependency 'YUKit/foundation'
		sss.source_files = 'YUKitSample/YUKit/YUKit/uikit/lib/**/*.{h,m,cpp,mm,c}'
	end

	ss.subspec 'category' do |sss|
		sss.ios.dependency 'YUKit/header'
		sss.ios.dependency 'YUKit/foundation'
		sss.source_files = 'YUKitSample/YUKit/YUKit/uikit/category/**/*.{h,m,cpp,mm,c}'
	end

	ss.source_files = 'YUKitSample/YUKit/YUKit/uikit/YU_UIKit.{h}'
end


#———frameworks

s.subspec 'frameworks' do |ss|
	ss.source_files = 'YUKitSample/YUKit/YUKit/frameworks/**/*.{h,m,cpp,mm,c}'
end


s.frameworks = 'UIKit', 'QuartzCore', 'Foundation'





end
