Pod::Spec.new do |s|
  s.name         = "GSTaggedProgressView"
  s.version      = "1.0.0"
  s.summary      = "GSTaggedProgressView is a horizontal progressview with tagged info."
  s.description  = <<-DESC
                    GSTaggedProgressView is a horizontal progressview with tagged on it. 
                   DESC
  s.homepage     = "https://github.com/Chren/GSTaggedProgressView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Aren" => "aren372@126.com" }
  s.platform = :ios, '7.0'
  s.source = { :git => 'https://github.com/Chren/GSTaggedProgressView.git', :tag => '1.0.0' }
  s.source_files = 'GSTaggedProgressView/*.{h,m}'
  s.requires_arc = true
end