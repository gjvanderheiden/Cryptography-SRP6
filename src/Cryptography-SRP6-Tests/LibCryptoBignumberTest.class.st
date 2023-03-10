"
A LibCryptoBignumberTest is a test class for testing the behavior of LibCryptoBignumber
"
Class {
	#name : #LibCryptoBignumberTest,
	#superclass : #TestCase,
	#category : #'Cryptography-SRP6-Tests-LibCrytpoC'
}

{ #category : #test }
LibCryptoBignumberTest >> testFree [
   " test to see free can be called several times."
   | number |
	number := LibCryptoBignumber new.
	number free; free; free.
	self assert: number primPointer isNil.
]

{ #category : #tests }
LibCryptoBignumberTest >> testModuloExponentModulo [
  "Simple test to mainlu check the interaction with libcrypto went ok."

	| number result modulo exponent |
	number := LibCryptoBignumber new setWithInteger: 3.
	modulo := LibCryptoBignumber new setWithInteger: 10.
	exponent := LibCryptoBignumber new setWithInteger: 2.
	result := number moduloExponent: exponent modulo: modulo.
	self assert: result asInteger equals: 9.

	modulo := LibCryptoBignumber new setWithInteger: 4.
	result := number moduloExponent: exponent modulo: modulo.
	self assert: result asInteger equals: 1
]

{ #category : #test }
LibCryptoBignumberTest >> testNumberOfBits [

	| number |
	number := LibCryptoBignumber new setWithInteger: 3.
	self assert: number numberOfBits equals: 2.
]

{ #category : #test }
LibCryptoBignumberTest >> testNumberOfBytes [

	| number |
	number := LibCryptoBignumber new setWithInteger: 25.
	self assert: number numberOfBytes equals: 1.
]
