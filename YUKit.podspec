Pod::Spec.new do |s|
    s.name         = 'YUKit'
    s.version      = '0.0.1'
    s.summary      = 'YUKit IOS轻量级快速开发框架（开发语言 objective-c 、c++）'
    s.homepage     = 'https://github.com/c6357/YUKit'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }  
    s.authors      = { "BruceYu" => "c6357@outlook.com" }
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/c6357/YUKit.git', :tag => 	s.version}
    s.source_files = 'YUKit/**/*.{h,m}'
    s.requires_arc = true
end
