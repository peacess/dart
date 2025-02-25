
PATH := $(HOME)/.pub-cache/bin:$(PATH)

gen:
	protoc --dart_out=grpc:./rpc_gen -I./rpc rpc/*.proto