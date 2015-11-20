Pod::Spec.new do |s|

  s.name         = "LCNavigationController"
  s.version      = "1.0.1"
  s.summary      = "The most popular NavigationController except UINavigationController. Support: http://www.leodong.com"
  s.homepage     = "https://github.com/LeoiOS/LCNavigationController"
  # s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Leo" => "leoios@sina.com" }
  s.social_media_url   = "http://www.leodong.com"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/LeoiOS/LCNavigationController.git", :tag => s.version }
  s.source_files  = "LCNavigationController/*"
  s.requires_arc = true

end
