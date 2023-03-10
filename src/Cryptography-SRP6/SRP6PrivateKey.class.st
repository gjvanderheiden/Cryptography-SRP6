Class {
	#name : #SRP6PrivateKey,
	#superclass : #Object,
	#instVars : [
		'hashedValue'
	],
	#category : #'Cryptography-SRP6-Core'
}

{ #category : #'instance creation' }
SRP6PrivateKey class >> newWithHash: hash salt: aSalt clearTextUsername: username clearTextPassword: password [
	^ self new initWithHash: hash salt: aSalt clearTextUsername: username clearTextPassword: password

]

{ #category : #initialization }
SRP6PrivateKey >> asByteArray [
	^ hashedValue.
]

{ #category : #initialization }
SRP6PrivateKey >> initWithHash: hash salt: aSalt clearTextUsername: username clearTextPassword: password [
	| passwordHashed |
	passwordHashed := hash hashStream: (ReadStream on: username, ':' utf8Encoded, password).
	hash initializeTotals.

	self initWithHash: hash salt: aSalt password: passwordHashed.
]

{ #category : #initialization }
SRP6PrivateKey >> initWithHash: hash salt: aSalt password: password [

	hashedValue := hash hashStream: (ReadStream on: aSalt asByteArray, password asByteArray).
]
