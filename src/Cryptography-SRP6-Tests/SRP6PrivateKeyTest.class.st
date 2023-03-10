Class {
	#name : #SRP6PrivateKeyTest,
	#superclass : #TestCase,
	#category : #'Cryptography-SRP6-Tests-Core'
}

{ #category : #tests }
SRP6PrivateKeyTest >> testAsByteArray [

	| privatekey |
	privatekey := SRP6PrivateKey
		              newWithHash: SHA1 new
		              salt: Rfc5054TestVectors salt
		              clearTextUsername: Rfc5054TestVectors identity
		              clearTextPassword: Rfc5054TestVectors password.


	self
		assert: privatekey asByteArray
		equals: Rfc5054TestVectors privateKey.
]
