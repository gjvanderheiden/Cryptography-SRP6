Class {
	#name : #SRP6ServerPublicKeyTest,
	#superclass : #TestCase,
	#category : #'Cryptography-SRP6-Tests-Core'
}

{ #category : #tests }
SRP6ServerPublicKeyTest >> testAsByteArray [


 | serverkey |

 serverkey :=  SRP6ServerPublicKey new initWithPrime: Rfc5054 N generator: Rfc5054 g multiplier: Rfc5054TestVectors multiplierTestValue  verifier: Rfc5054TestVectors verifyTestValue  serverEphPrvtKey: Rfc5054TestVectors serverPrivateEphemeral.

 self assert: serverkey asByteArray equals: Rfc5054TestVectors serverPublicKey.
]
