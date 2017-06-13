 
YUKit:

#配置
mach-o type  static library

headers public



hmeiOS  header search path

"${PODS_ROOT}/../YUKit

Other Linker Flags
-ObjC



#---uikit
s.subspec 'uikit' do |ss|
ss.subspec 'lib' do |sss|
sss.ios.dependency 'YUKitSample/YUKit/YUKit/header'
sss.ios.dependency 'YUKitSample/YUKit/YUKit/foundation'
sss.source_files = 'YUKitSample/YUKit/YUKit/uikit/lib/**/*.{h,m,cpp,mm,c}'
end

ss.subspec 'category' do |sss|
sss.ios.dependency 'YUKitSample/YUKit/YUKit/header'
sss.ios.dependency 'YUKitSample/YUKit/YUKit/foundation'
sss.source_files = 'YUKitSample/YUKit/YUKit/uikit/category/**/*.{h,m,cpp,mm,c}'
end

ss.source_files = 'YUKitSample/YUKit/YUKit/uikit/YU_UIKit.{h}'
end

#---uikit
s.subspec 'uikit' do |ss|
ss.subspec 'lib' do |sss|
#sss.ios.dependency 'YUKitSample/YUKit/YUKit/header'
sss.ios.dependency 'YUKitSample/YUKit/YUKit/foundation'
sss.source_files = 'YUKitSample/YUKit/YUKit/uikit/lib/**/*.{h,m,cpp,mm,c}'
end

ss.subspec 'category' do |sss|
#sss.ios.dependency 'YUKitSample/YUKit/YUKit/header'
sss.ios.dependency 'YUKitSample/YUKit/YUKit/foundation'
sss.source_files = 'YUKitSample/YUKit/YUKit/uikit/category/**/*.{h,m,cpp,mm,c}'
end

ss.source_files = 'YUKitSample/YUKit/YUKit/uikit/YU_UIKit.{h}'
end
