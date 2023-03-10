"
A LibCryptoBignumberTest is a test class for testing the behavior of LibCryptoBignumber
"
Class {
	#name : #LibCryptoBignumberTest,
	#superclass : #TestCase,
	#category : #'Cryptography-SRP6-Tests-LibCrytpoC'
}

{ #category : #tests }
LibCryptoBignumberTest >> testAddModulo [

	| result a b modulo |
	a := LibCryptoBignumber new setWithInteger: 3.
	b := LibCryptoBignumber new setWithInteger: 4.
	modulo :=  LibCryptoBignumber new setWithInteger: 5.
	result := a add: b modulo: modulo.
	self assert: result asInteger equals: 2.
]

{ #category : #tests }
LibCryptoBignumberTest >> testExponentModulo [
  "Simple test to mainlu check the interaction with libcrypto went ok."

	| number result modulo exponent |
	number := LibCryptoBignumber new setWithInteger: 3.
	modulo := LibCryptoBignumber new setWithInteger: 10.
	exponent := LibCryptoBignumber new setWithInteger: 2.
	result := number exponent: exponent modulo: modulo.
	self assert: result asInteger equals: 9.

	modulo := LibCryptoBignumber new setWithInteger: 4.
	result := number exponent: exponent modulo: modulo.
	self assert: result asInteger equals: 1
]

{ #category : #test }
LibCryptoBignumberTest >> testFree [
   " test to see free can be called several times."
   | number |
	number := LibCryptoBignumber new.
	number free; free; free.
	self assert: number primPointer isNil.
]

{ #category : #test }
LibCryptoBignumberTest >> testModulo [

	| result a modulo |
	a := LibCryptoBignumber new setWithInteger: 9.
	
	modulo :=  LibCryptoBignumber new setWithInteger: 5.
	result := a modulo: modulo.
	self assert: result asInteger equals: 4.
]

{ #category : #tests }
LibCryptoBignumberTest >> testMultiplyWithModulo [

	| result a b modulo |
	a := LibCryptoBignumber new setWithInteger: 3.
	b := LibCryptoBignumber new setWithInteger: 4.
	modulo :=  LibCryptoBignumber new setWithInteger: 10.
	result := a multiplyWith: b modulo: modulo.
	self assert: result asInteger equals: 2.
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

{ #category : #test }
LibCryptoBignumberTest >> testPlus [

	| numberA numberB sum |
	numberA := LibCryptoBignumber new setWithInteger: 33.
	numberB := LibCryptoBignumber new setWithInteger: 55.
	sum := numberA + numberB.
	self assert: sum asInteger equals: 88.
	sum := numberA + numberA.
	self assert: sum asInteger equals: 66
]

{ #category : #tests }
LibCryptoBignumberTest >> testStar [
 
   | numberA numberB product |
	numberA := LibCryptoBignumber new setWithInteger: 3.	
	numberB  := LibCryptoBignumber new setWithInteger: 5.
	product := numberA * numberB.
	self assert: product asInteger equals: 15.
	product := numberA * numberA.
	self assert: product asInteger equals: 9.
]
