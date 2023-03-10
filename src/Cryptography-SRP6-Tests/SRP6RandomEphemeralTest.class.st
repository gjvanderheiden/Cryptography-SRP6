"
A SRP6RandomEphemeralTest is a test class for testing the behavior of SRP6RandomEphemeral
"
Class {
	#name : #SRP6RandomEphemeralTest,
	#superclass : #TestCase,
	#category : #'Cryptography-SRP6-Tests-Core'
}

{ #category : #test }
SRP6RandomEphemeralTest >> testAsByteArray [
	|srp6RandomEphemeral|
	srp6RandomEphemeral := SRP6RandomEphemeral newWithRandom: Random new  andPrime: Rfc5054 N.
	
	self assert: srp6RandomEphemeral asByteArray size equals: 32.
]
