 
YUKit:

#配置
mach-o type  static library

headers public



hmeiOS  header search path

"${PODS_ROOT}/../YUKit

Other Linker Flags
-ObjC



#———uikit
s.subspec 'uikit' do |ss|
ss.subspec 'lib' do |sss|
sss.ios.dependency 'YUKit/header'
sss.ios.dependency 'YUKit/foundation'
sss.source_files = 'YUKit/uikit/lib/**/*.{h,m,cpp,mm,c}'
end

ss.subspec 'category' do |sss|
sss.ios.dependency 'YUKit/header'
sss.ios.dependency 'YUKit/foundation'
sss.source_files = 'YUKit/uikit/category/**/*.{h,m,cpp,mm,c}'
end

ss.source_files = 'YUKit/uikit/YU_UIKit.{h}'
end

