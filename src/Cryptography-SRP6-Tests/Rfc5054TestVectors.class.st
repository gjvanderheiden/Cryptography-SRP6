Class {
	#name : #Rfc5054TestVectors,
	#superclass : #Object,
	#category : #'Cryptography-SRP6-Tests-RFC5054'
}

{ #category : #accessing }
Rfc5054TestVectors class >> identity [

	^ 'alice' utf8Encoded  
]

{ #category : #accessing }
Rfc5054TestVectors class >> multiplierTestValue [

	^ #[ 16r75 16r56 16rAA 16r04 16r5A 16rEF 16r2C 16rDD 16r07 16rAB 16rAF 16r0F 16r66 16r5C 16r3E 16r81 16r89 16r13 16r18 16r6F ]
]

{ #category : #accessing }
Rfc5054TestVectors class >> password [

	^ 'password123' utf8Encoded  
]

{ #category : #accessing }
Rfc5054TestVectors class >> privateKey [

  ^ #[ 16r94 16rB7 16r55 16r5A 16rAB 16rE9 16r12 16r7C 16rC5 16r8C 16rCF 16r49 16r93 16rDB 16r6C 16rF8 16r4D 16r16 16rC1 16r24].
]

{ #category : #accessing }
Rfc5054TestVectors class >> salt [

  ^ #[ 16rBE 16rB2 16r53 16r79 16rD1 16rA8 16r58 16r1E 16rB5 16rA7 16r27 16r67 16r3A 16r24 16r41 16rEE ].
]

{ #category : #accessing }
Rfc5054TestVectors class >> verifyTestValue [

	^ #[ 16r7E 16r27 16r3D 16rE8 16r69 16r6F 16rFC 16r4F 16r4E 16r33 16r7D 16r05 16rB4 16rB3 16r75 16rBE 16rB0 16rDD 16rE1 16r56 16r9E 16r8F 16rA0 16r0A 16r98 16r86 16rD8 16r12 16r9B 16rAD 16rA1 16rF1 16r82 16r22 16r23 16rCA 16r1A 16r60 16r5B 16r53 16r0E 16r37 16r9B 16rA4 16r72 16r9F 16rDC 16r59 16rF1 16r05 16rB4 16r78 16r7E 16r51 16r86 16rF5 16rC6 16r71 16r08 16r5A 16r14 16r47 16rB5 16r2A 16r48 16rCF 16r19 16r70 16rB4 16rFB 16r6F 16r84 16r00 16rBB 16rF4 16rCE 16rBF 16rBB 16r16 16r81 16r52 16rE0 16r8A 16rB5 16rEA 16r53 16rD1 16r5C 16r1A 16rFF 16r87 16rB2 16rB9 16rDA 16r6E 16r04 16rE0 16r58 16rAD 16r51 16rCC 16r72 16rBF 16rC9 16r03 16r3B 16r56 16r4E 16r26 16r48 16r0D 16r78 16rE9 16r55 16rA5 16rE2 16r9E 16r7A 16rB2 16r45 16rDB 16r2B 16rE3 16r15 16rE2 16r09 16r9A 16rFB]
]
