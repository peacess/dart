.PHONY: format clean
format:
	dart format ./ -l 160
	cd packages/error_panic/lang/go_panic && go fmt ./*.go
	cd packages/error_panic/lang/rust_panic && cargo fmt
clean:
	rm -rf ./packages/error_panic/lang/go_panic/*.dll
	rm -rf ./packages/error_panic/lang/go_panic/*.os
	rm -rf ./packages/error_panic/lang/go_panic/*.dylib
	rm -rf ./packages/error_panic/lang/rust_panic/target