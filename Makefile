proto_gen_dir := pb
proto_dir := submodules/proto

protogen:
	rm -rf ${proto_gen_dir}
	make -C ${proto_dir} swift
	mkdir -p ${proto_gen_dir}
	mv ${proto_dir}/proto/*.swift ${proto_gen_dir}

build_debug:
	buck build //:TodoApp

build_release:
	buck build //:TodoApp#iphoneos-armv7

clean:
	buck clean

project: clean
	rm -rf **/*.{xcworkspace,xcodeproj}
	buck project //:Workspace
	open Todo.xcworkspace