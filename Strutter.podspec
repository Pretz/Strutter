Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "Strutter"
  s.version      = "0.0.1"
  s.summary      = "A Swift µFramework for defining AutoLayout constraints"

  s.description  = <<-DESC
                    Strutter simplifies defining constraints using iOS 9's NSLayoutAnchor
                    It reduces boilerplate and increases readability when defining constraints programatically.
                   DESC

  s.homepage     = "https://github.com/Pretz/Strutter"
  s.license      = "MIT"

  s.author             = { "Alex Pretzlav" => "alex@pretzlav.com" }
  s.social_media_url   = "http://twitter.com/apretz"

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.11"

  s.source       = { :git => "https://github.com/Pretz/Strutter.git", :tag => s.version }

  s.source_files  = "Strutter/*.swift"

  s.subspec 'Core' do |core|

  end

  s.subspec 'OALayoutAnchor' do |compat|
    compat.platform = :ios, '7.0'
    compat.ios.deployment_target = '7.0'
    compat.dependency "OALayoutAnchor"
    compat.compiler_flags = "-D OALayout"
  end
end
