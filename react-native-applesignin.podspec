require "json"
package = JSON.parse(File.read(File.join(__dir__, "package.json")))
Pod::Spec.new do |s|
  s.name         = "react-native-applesignin"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-applesignin
                   DESC
  s.homepage     = "https://github.com/MemorresR/react-native-applesignin"
  s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Memorres" => "ranjana@memorres.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/MemorresR/react-native-applesignin.git", :tag => "#{s.version}" }
  s.source_files = "ios/**/*.{h,c,m,swift}"
  s.requires_arc = true
  s.dependency "React"
end
