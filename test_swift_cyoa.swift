#!/usr/bin/env swift

print("Hello! Enter a number")

if let line = readLine() {
	print(line)

	if let _ = Int(line) {
		print("Very good!")
		print("Your choice: " + line)
	} else {
		print("Not a number!")
	}
}
