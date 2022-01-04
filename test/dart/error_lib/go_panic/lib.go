package main

import "C"

//export ErrorPanic
func ErrorPanic() int32 {
	panic("go")
	return 0
}

func main() {}
