
ifeq ($(OS),Windows_NT)
	NAME := go_panic.dll
else ifeq ($(shell uname -s),Linux)
	NAME := go_panic.so
else ifeq ($(shell uname -s),Darwin)
	NAME := go_panic.dylib
else
	$(error Unknown operating system. Please update the Makefile.)
endif
GO := $(shell which go)

gen:
	cd lang/go_panic && ${GO} build -o ${NAME} -buildmode=c-shared
	cd lang/rust_panic && cargo build
	dart run ffigen
