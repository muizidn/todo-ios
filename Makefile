proto_gen_dir := pb
proto_dir := submodules/proto

protogen:
	rm -rf ${proto_gen_dir}
	make -C ${proto_dir} swift
	mkdir -p ${proto_gen_dir}
	mv ${proto_dir}/proto/*.swift ${proto_gen_dir}
