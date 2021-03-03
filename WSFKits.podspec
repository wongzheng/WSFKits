#
# Be sure to run `pod lib lint WSFKits.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WSFKits'
  s.version          = '0.2.7'
  s.summary          = 'WSFKits.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
	Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wongzheng/WSFKits'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wongzheng' => 'zbad1171@qq.com' }
  s.source           = { :git => 'https://github.com/wongzheng/WSFKits.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'WSFKits/WSFKits.h'
  
  # s.resource_bundles = {
  #   'WSFKits' => ['WSFKits/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '>= 2.3'
  # s.dependency 'MJRefresh', '>= 3.1.12'
  s.subspec 'Constants' do |ss|
    ss.source_files = 'WSFKits/Constants/**/*'
  end

  s.subspec 'Categories' do |ss|
    ss.source_files = 'WSFKits/Categories/**/*'
  end

  s.subspec 'Crash' do |ss|
  	ss.dependency 'WSFKits/Categories'
  	ss.dependency 'WSFKits/Constants'
    ss.source_files = 'WSFKits/Crash/**/*'
  end

end
