Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.name         = "DeSerializer"
  s.version      = "2.0.0"
  s.summary      = "Lightweight library for JSON to object mapping using KVC and ObjC-Runtime"

  s.description  = <<-DESC
  Most of mappers require writing a lot of code that manually maps on object on another. 
  This library is supposed to do it autimatically, leaving to user possibility of defining own transformations. 
                   DESC

  s.homepage     = "https://github.com/IljaKosynkin/DeSerializer"

  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }

  s.author             = { "Ilia Kosynkin" => "ilja.kosynkin@gmail.com" }

  s.dependency 'KlappaDeSerializer'

  s.source       = { :git => "https://github.com/IljaKosynkin/DeSerializer.git", :tag => "v2.0.0" }

  s.source_files  = "DeSerializer", "DeSerializer/**/*.{swift}"
end
