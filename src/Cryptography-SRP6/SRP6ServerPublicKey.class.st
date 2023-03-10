Class {
	#name : #SRP6ServerPublicKey,
	#superclass : #Object,
	#instVars : [
		'byteArray'
	],
	#category : #'Cryptography-SRP6-Core'
}

{ #category : #initialization }
SRP6ServerPublicKey >> asByteArray [

	^ byteArray 
]

{ #category : #initialization }
SRP6ServerPublicKey >> initWithPrime: aPrime generator: aGenerator multiplier: aMultiplier verifier: aVerifier serverEphPrvtKey: serverEphPrvtKey [

	| N g k v b B |
	N := LibCryptoBignumber new setWithByteArray: aPrime asByteArray.
	g := LibCryptoBignumber new setWithByteArray: aGenerator asByteArray.
	k := LibCryptoBignumber new setWithByteArray: aMultiplier asByteArray.
	v := LibCryptoBignumber new setWithByteArray: aVerifier asByteArray.
	b := LibCryptoBignumber new setWithByteArray:
		     serverEphPrvtKey asByteArray.



	B := k * v add: (g exponent: b modulo: N) modulo: N.
	byteArray := B asByteArray 
]
