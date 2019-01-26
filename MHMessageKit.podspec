Pod::Spec.new do |s|

  s.name         = "MHMessageKit"
  s.version      = "1.0.2"
  s.source       = { :git => "https://github.com/KoCMoHaBTa/#{s.name}.git", :tag => "#{s.version}" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Milen Halachev"
  s.summary      = "Strongly typed and Swiftly convenient wrapper around NotificationCenter and NotificationQueue."
  s.homepage     = "https://github.com/KoCMoHaBTa/#{s.name}"

  s.swift_version = "4.2"
  s.ios.deployment_target = "8.0"

  s.source_files  = "#{s.name}/**/*.swift", "#{s.name}/**/*.{h,m}"
  s.public_header_files = "#{s.name}/**/*.h"

end
