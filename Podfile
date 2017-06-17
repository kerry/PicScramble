# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

# Our Libraries
def libraries
    pod 'AlamofireImage'
    pod 'PopupDialog'
    pod 'KGProgress'
    pod 'StatefulViewController'
    pod 'SwiftMessages'
    pod 'AlamofireObjectMapper', '~> 4.0'
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