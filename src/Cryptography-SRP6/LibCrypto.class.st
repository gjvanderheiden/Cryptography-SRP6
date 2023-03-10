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
