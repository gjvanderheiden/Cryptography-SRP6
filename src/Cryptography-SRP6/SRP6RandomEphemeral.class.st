Class {
	#name : #SRP6RandomEphemeral,
	#superclass : #Object,
	#instVars : [
		'byteArray'
	],
	#category : #'Cryptography-SRP6-Core'
}

{ #category : #'instance creation' }
SRP6RandomEphemeral class >> newWithRandom: random andPrime: prime [
	^ self new initWithRandom: random  andPrime: prime 
]

{ #category : #'as yet unclassified' }
SRP6RandomEphemeral >> asByteArray [
	

^ byteArray 
]

{ #category : #'as yet unclassified' }
SRP6RandomEphemeral >> initWithRandom: random andPrime: prime [

	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	| number primeAsInteger bitLength |
	primeAsInteger := prime asInteger.

	number := random nextInteger: prime asInteger.
	bitLength := number highBit.
	bitLength > 256 ifTrue: [ 
		number := number bitShift: (bitLength - 256) negated  ].
	byteArray := number asByteArray
]
