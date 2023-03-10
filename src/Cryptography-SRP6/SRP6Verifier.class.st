Class {
	#name : #SRP6Verifier,
	#superclass : #Object,
	#instVars : [
		'prime',
		'generator',
		'privateKey'
	],
	#category : #'Cryptography-SRP6-Core'
}

{ #category : #converting }
SRP6Verifier >> asByteArray [

	| bnG bnN bnX bnVerifier answer |
	bnG := LibCryptoBignumber new setWithByteArray: generator .
	bnN := LibCryptoBignumber new  setWithByteArray: prime.
	bnX := LibCryptoBignumber new setWithByteArray: privateKey.
	bnVerifier := bnG exponent:bnX  modulo: bnN.
	answer := bnVerifier asByteArray.
	bnG free. bnN free. bnX free. bnVerifier free.

	^ answer
]

{ #category : #initialization }
SRP6Verifier >> initWithPrime: aPrime generator: aGenerator privateKey: aPirvateKey [
	prime := aPrime asByteArray .
	generator := aGenerator asByteArray.
	privateKey := aPirvateKey asByteArray.
]
