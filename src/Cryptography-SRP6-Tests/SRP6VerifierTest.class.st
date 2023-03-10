"
A SRP6VerifierTest is a test class for testing the behavior of SRP6Verifier
"
Class {
	#name : #SRP6VerifierTest,
	#superclass : #TestCase,
	#category : #'Cryptography-SRP6-Tests-Core'
}

{ #category : #tests }
SRP6VerifierTest >> testAsByteArray [

	| verifier |
	verifier := SRP6Verifier new
		            initWithPrime: Rfc5054 N
		            generator: Rfc5054 g
		            privateKey: Rfc5054TestVectors privateKey.
	
   self assert: verifier asByteArray equals: Rfc5054TestVectors verifyTestValue. 
]
