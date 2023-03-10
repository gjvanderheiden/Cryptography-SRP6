"
A SRP6MultiplierTest is a test class for testing the behavior of SRP6Multiplier
"
Class {
	#name : #SRP6MultiplierTest,
	#superclass : #TestCase,
	#category : #'Cryptography-SRP6-Tests-Core'
}

{ #category : #test }
SRP6MultiplierTest >> testAsByteArray [

	| multiplier |
	
  multiplier := SRP6Multiplier new initWithHash: SHA1 new andPrime: Rfc5054 N andGenerator: Rfc5054 g.


  self assert: multiplier asByteArray equals: Rfc5054TestVectors multiplierTestValue  
]
