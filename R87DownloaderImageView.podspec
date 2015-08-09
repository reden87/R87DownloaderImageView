Pod::Spec.new do |s|

  s.name               = "R87DownloaderImageView"
  s.version            = "1.0.1"
  s.summary            = "R87DownloaderImageView is a UIImageView subclass which makes possible to download an image from the provided link."
  
  s.description        = <<-DESC
                         R87DownloaderImageView is a UIImageView subclass which makes possible to download an image from the provided link.
                         
                         While the download is in progress the default or a custom propgress bar is displayed, the download returns a success block with the downloaded image or a failure block in case of an error.
                         DESC

  s.homepage           = "https://github.com/reden87/R87DownloaderImageView"
  s.screenshots        = "https://camo.githubusercontent.com/e2286c9a0e78c6bfdc2534e4f56027c8041e3a1a/687474703a2f2f726564656e38372e696e666f2f4769744875622f523837496d616765566965772e676966"

  s.license            = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Gergő Németh" => "http://reden87.info/" }
  s.social_media_url   = "http://twitter.com/reden87"

  s.platform           = :ios
  s.platform           = :ios, "5.0"

  s.source             = { :git => "https://github.com/reden87/R87DownloaderImageView.git", :tag => "1.0.1" }

  s.source_files       = "R87DownloaderImageView/*.{h,m}"

  s.requires_arc       = true

  s.frameworks         = "Foundation", "UIKit"

end
