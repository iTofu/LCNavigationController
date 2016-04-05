Pod::Spec.new do |s|

  s.name         = "LCNavigationController"
  s.version      = "1.0.6"
  s.summary      = "The most popular navigationController except UINavigationController. Support: http://LeoDev.me"
  s.homepage     = "https://github.com/iTofu/LCNavigationController"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Leo" => "devtip@163.com" }
  s.social_media_url   = "http://LeoDev.me"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/iTofu/LCNavigationController.git", :tag => s.version }
  s.source_files = "LCNavigationController/*"
  s.requires_arc = true

end
