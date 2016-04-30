Pod::Spec.new do |s|
  s.name         = "JHDropdown"
  s.version      = "0.1.66"
  s.summary      = "JHDropdown is a lightweight dropdown message animation written entirely in Swift."

  s.description  = <<-DESC
                    JHDropdown is a lightweight dropdown message animation written entirely in Swift.
                    - Very easy to use, single line of code `Dropdown.show(:)`
                    - Height automatically adjusts based on message string
                    - Offers customized dropdown, as well as default success, warning, and error messages
                    DESC
  s.homepage     = "https://github.com/ohthatsjhall/JHDropdown"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Justin Hall" => "jhall.auburn@gmail.com" }
  s.source       = { :git => "https://github.com/ohthatsjhall/JHDropdown.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'JHDropdown/**/*.swift'
  s.resource     = 'JHDropdown/*.xcassets'
end