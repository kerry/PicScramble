# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

# Our Libraries
def libraries
    pod 'AlamofireImage', '~> 3.2'
    pod 'PopupDialog', '~> 0.5'
    pod 'KGProgress', '~> 0.1'
    pod 'StatefulViewController', '~> 3.0'
    pod 'SwiftMessages'
end

# Test Libraries
def test_pods
    pod 'Quick', :configurations => ['debug']
    pod 'Nimble', :configurations => ['debug']
end


target 'PicScramble' do
    use_frameworks!
    libraries
end

target 'PicScrambleTests' do
    use_frameworks!
    libraries
    test_pods
end