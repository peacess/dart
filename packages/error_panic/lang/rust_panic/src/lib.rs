#[no_mangle]
pub extern "C" fn ErrorPanic() -> i32 {
    panic!("test")
}
