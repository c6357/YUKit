Pod::Spec.new do |s|

    s.name         = 'YUKit'
    s.module_name  = 'YUKit' 
    s.version      = '0.0.1'
    s.summary      = 'YUKit IOS轻量级快速开发框架(开发语言 objective-c 、c++）'
    s.homepage     = 'https://github.com/c6357/YUKit'
    s.license      = "MIT"  
    s.authors      = { "BruceYu" => "c6357@outlook.com" }
    s.platform     = :ios, '7.0'

    #s.ios.deployment_target = '7.0'

    s.source       = {:git => 'https://github.com/c6357/YUKit.git', :tag => 	s.version}

    #s.source_files = 'YUKit/**/*.{h,m}'
    #s.public_header_files = 'YUKit/**/*.{h}'
    s.public_header_files = 'YUKit/*.{h}'

    s.requires_arc = true



 s.subspec 'uikit' do |ss|
 	ss.source_files = 'YUKit/uikit/**/*'
	#ss.dependency 'YUKit/foundation'

 end

 s.subspec 'foundation' do |ss|
 	ss.source_files = 'YUKit/foundation/**/*'
	#ss.dependency 'YUKit/uikit'
 end

 s.subspec 'base' do |ss|
 	ss.source_files = 'YUKit/base/**/*'
       #ss.dependency 'YUKit/foundation'
	ss.dependency 'YUKit/uikit'
 end

 s.subspec 'services' do |ss|
        
 	ss.source_files = 'YUKit/services/**/*'
       #ss.dependency 'YUKit'
      ss.dependency 'YUKit/foundation'
	#ss.dependency 'YUKit/uikit'
 	ss.ios.vendored_frameworks = 'YUDBFramework/YUDBFramework.framework'
 end


#non_arc_files = 'YUKit/foundation/lib/Reachability/Reachability.{h,m}'
#s.ios.exclude_files = non_arc_files
#s.subspec 'no-arc' do |sna|
#   sna.requires_arc = false
#   sna.source_files = non_arc_files
# end



  s.dependency 'MJRefresh', '~> 2.2.0'
  s.dependency 'Masonry', '~> 0.6.2'
  s.dependency 'AFNetworking' , '~>2.5.4'

  #s.ios.vendored_frameworks = 'YUDBFramework/YUDBFramework.framework'
  s.frameworks = 'UIKit', 'QuartzCore', 'Foundation' 

end
