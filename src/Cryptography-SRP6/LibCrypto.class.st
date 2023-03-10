Class {
	#name : #LibCrypto,
	#superclass : #FFILibrary,
	#instVars : [
		'pointerToBN'
	],
	#category : #'Cryptography-SRP6-LibCrytpoC'
}

{ #category : #'accessing - platform' }
LibCrypto >> macLibraryName [
	^ 'libcrypto.dylib'
]

{ #category : #'accessing - platform' }
LibCrypto >> unix64LibraryName [
	^ 'libcrypto.so'
]

{ #category : #'accessing - platform' }
LibCrypto >> win32LibraryName [
	^ 'libcrypto.dll'
]
