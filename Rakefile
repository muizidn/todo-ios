require 'fileutils'

task :install_xctemplate do
  TEMPLATE = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/File Templates"
  CUSTOM_DIR = TEMPLATE + "/Custom"
  RX_MVVM_DIR = "NoteApp.xctemplate"
  puts "Prepare directory #{CUSTOM_DIR}"
  FileUtils.mkdir CUSTOM_DIR unless File.exists?(CUSTOM_DIR)
  puts "Done!"
  puts "Copy '#{RX_MVVM_DIR}' to '#{CUSTOM_DIR}'"
  FileUtils.cp_r RX_MVVM_DIR, CUSTOM_DIR
  puts "Done!"
  puts "Happy coding!"
end

task :gen_proto do
  # requires absolute path
  `
  protoc proto/*.proto \
		--proto_path=proto/ \
		--plugin=$(which protoc-gen-swift) \
		--swift_opt=Visibility=Public \
		--swift_out=proto/gen
  protoc proto/*.proto \
		--proto_path=proto/ \
		--plugin=$(which protoc-gen-grpc-swift) \
		--grpc-swift_opt=Visibility=Public \
		--grpc-swift_out=proto/gen
  `
end
