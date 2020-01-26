require 'fileutils'

task :install_xctemplate do
  TEMPLATE = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/File Templates"
  CUSTOM_DIR = TEMPLATE + "/Custom"
  RX_MVVM_DIR = "TodoApp.xctemplate"
  puts "Prepare directory #{CUSTOM_DIR}"
  FileUtils.mkdir CUSTOM_DIR unless File.exists?(CUSTOM_DIR)
  puts "Done!"
  puts "Copy '#{RX_MVVM_DIR}' to '#{CUSTOM_DIR}'"
  FileUtils.cp_r RX_MVVM_DIR, CUSTOM_DIR
  puts "Done!"
  puts "Happy coding!"
end
