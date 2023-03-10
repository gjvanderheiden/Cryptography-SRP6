Class {
	#name : #SRP6Multiplier,
	#superclass : #Object,
	#instVars : [
		'multiplierValue'
	],
	#classVars : [
		'value'
	],
	#category : #'Cryptography-SRP6-Core'
}

{ #category : #converting }
SRP6Multiplier >> asByteArray [
  ^ multiplierValue
]

{ #category : #converting }
SRP6Multiplier >> initWithHash: hash andPrime: aPrime andGenerator: aGenerator [
	multiplierValue := hash hashStream: (ReadStream on: aPrime asByteArray, (aGenerator asByteArrayOfSize: aPrime size))
]
