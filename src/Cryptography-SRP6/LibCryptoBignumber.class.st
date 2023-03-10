Class {
	#name : #LibCryptoBignumber,
	#superclass : #Object,
	#instVars : [
		'pointerToBN',
		'pointerToCtx'
	],
	#category : #'Cryptography-SRP6-LibCrytpoC'
}

{ #category : #'mathematical functions' }
LibCryptoBignumber >> * otherBigNumber [
	| answer resultCFunction |
	answer := self class new.
	resultCFunction := self prim_bn_mul: otherBigNumber primPointer withResultIn: answer primPointer.
	resultCFunction ~= 1 ifTrue: [ self error: self prim_get_err  ]. 
	^ answer.
]

{ #category : #'mathematical functions' }
LibCryptoBignumber >> + otherBigNumber [
	| answer resultCFunction |
	answer := self class new.
	resultCFunction := self prim_bn_add: otherBigNumber primPointer withResultIn: answer primPointer.
	resultCFunction ~= 1 ifTrue: [ self error: self prim_get_err  ]. 
	^ answer.
]

{ #category : #'mathematical functions' }
LibCryptoBignumber >> add: addition modulo: modulo [

	| returnValueCCheck answer |
	answer := self class new.
	returnValueCCheck := self
		               prim_bn_mod_add_WithResultIn: answer primPointer
		               add: addition primPointer
		               modulo: modulo primPointer.
	returnValueCCheck ~= 1 ifTrue: [ 
		Transcript
			crShow: 'ohoh : ';
			show: self prim_get_err ].
	^ answer
]

{ #category : #converting }
LibCryptoBignumber >> asByteArray [

	| byteArray array primResult |
	array := FFIArray externalNewType: #uchar size: self numberOfBytes.
	primResult := self prim_bn_bn2binTo: array tfPointerAddress.


	primResult ~= array size ifTrue: [ 
		Transcript
			crShow: 'asByteArray';
			show: primResult ].
	byteArray := array asByteArray.
	array free.
	^ byteArray
]

{ #category : #converting }
LibCryptoBignumber >> asInteger [

	^ self asByteArray asInteger 
]

{ #category : #'mathematical functions' }
LibCryptoBignumber >> exponent: exponentBignumber modulo: moduloBignumber [

	| returnValueCCheck answer |
	answer := self class new.
	returnValueCCheck := self
		               prim_bn_mod_exp_WithResultIn: answer primPointer
		               p: exponentBignumber primPointer
		               m: moduloBignumber primPointer.
	returnValueCCheck ~= 1 ifTrue: [ 
		Transcript
			crShow: 'ohoh : ';
			show: self prim_get_err ].
	^ answer
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> ffiLibrary [
	
	^ LibCrypto 
]

{ #category : #'initialization-release' }
LibCryptoBignumber >> finalize [ 

	self free.
]

{ #category : #'initialization-release' }
LibCryptoBignumber >> free [

	pointerToBN ifNil: [ 
		self
			prim_bn_free;
			prim_ctx_free ].
	pointerToBN := nil.
	pointerToCtx := nil
]

{ #category : #'initialization-release' }
LibCryptoBignumber >> initialize [ 

	self newPrim.
]

{ #category : #'mathematical functions' }
LibCryptoBignumber >> modulo: otherBigNumber [
	| answer resultCFunction |
	answer := self class new.
	resultCFunction := self prim_bn_nmodWithResultIn: answer primPointer modulo: otherBigNumber primPointer.
	resultCFunction ~= 1 ifTrue: [ self error: self prim_get_err  ]. 
	^ answer.
]

{ #category : #'mathematical functions' }
LibCryptoBignumber >> multiplyWith: multiplier modulo: modulo [

	| returnValueCCheck answer |
	answer := self class new.
	returnValueCCheck := self
		               prim_bn_mod_mul_WithResultIn: answer primPointer
		               multiplyWith: multiplier primPointer
		               modulo: modulo primPointer.
	returnValueCCheck ~= 1 ifTrue: [ 
		Transcript
			crShow: 'ohoh : ';
			show: self prim_get_err ].
	^ answer
]

{ #category : #'initialization-release' }
LibCryptoBignumber >> newPrim [

	pointerToBN ifNil: [ 
		pointerToBN := self prim_bn_new.
		pointerToCtx := self prim_ctx_new ]
]

{ #category : #accessing }
LibCryptoBignumber >> numberOfBits [
  ^ self ffiCall: #( int BN_num_bits(void*  pointerToBN) )  

]

{ #category : #accessing }
LibCryptoBignumber >> numberOfBytes [
  "I'll answer the number of bytes occupied in byte array representation" 
  "latest lib crypto has a function for this, but not so in the version Pharo ships."
	| numberOfBytes |
	numberOfBytes := (self numberOfBits / 8) truncated.

	((self numberOfBits rem: 8 )> 0) ifTrue: [ 
		numberOfBytes := numberOfBytes + 1 ].


	^ numberOfBytes 
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> primPointer [
	^ pointerToBN

]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_add: pointerToBnToAdd withResultIn: resultPointer [
  "Call primitive. Note that the answer is an integer or C type Boolean. 1 or true
   is a success."
	^ self ffiCall: #(  int BN_add(void *resultPointer, void *pointerToBN, void *pointerToBnToAdd) )
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_bin2bn: anByteArray withLen: len [
	^ self ffiCall: #( void *BN_bin2bn(uchar *anByteArray, int len, void *pointerToBN))  
	

]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_bn2binTo: to [
	^ self ffiCall: #( int BN_bn2bin(void *pointerToBN, uchar *to) )
	

]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_free [
	self ffiCall: #( void BN_free(void* pointerToBN) )  
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_modWithResultIn: result p: p [ 
  "Call primitive. Note that the answer is an integer or C type Boolean. 1 or true
   is a success."

	^ self ffiCall: #(  int BN_GF2m_mod(void *result, void *pointerToBN, void *p) )
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_mod_add_WithResultIn: pointerToResult add: pointerToB modulo: pointerToM [ 
  "Call primitive. Note that the answer is an integer or C type Boolean. 1 or true
   is a success."

	^ self ffiCall: #( int BN_mod_add(void *pointerToResult, void *pointerToBN, void *pointerToB, void *pointerToM,
               void *pointerToCtx) ) 
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_mod_exp_WithResultIn: result p: p m: m [
  "Call primitive. Note that the answer is an integer or C type Boolean. 1 or true
   is a success."
	^ self ffiCall: #(  int BN_mod_exp(void *result, void *pointerToBN,  void *p,
         void *m, void *pointerToCtx) )
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_mod_mul_WithResultIn: pointerToResult multiplyWith: pointerToB modulo: pointerToM [ 
  "Call primitive. Note that the answer is an integer or C type Boolean. 1 or true
   is a success."

	^ self ffiCall: #( int BN_mod_mul(void *pointerToResult, void *pointerToBN, void *pointerToB, void *pointerToM,
               void *pointerToCtx) ) 
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_mul: pointerToBnToAdd withResultIn: resultPointer [
  "Call primitive. Note that the answer is an integer or C type Boolean. 1 or true
   is a success."
	^ self ffiCall: #(  int BN_mul(void *resultPointer, void *pointerToBN, void *pointerToBnToAdd, void* pointerToCtx) )
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_new [
	^ self ffiCall: #(  void* BN_new (void) )

]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_nmodWithResultIn: result modulo: pointerToModulo [
  "Call primitive. Note that the answer is an integer or C type Boolean. 1 or true
   is a success."

	^ self ffiCall: #( int BN_nnmod(void *result, void *pointerToBN, void *pointerToModulo, void *pointerToCtx) )
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_ctx_free [
	self ffiCall: #(  void BN_CTX_free(void* pointerToCtx) )

]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_ctx_new [
	^ self ffiCall: #(  void *BN_CTX_new(void) )

]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_get_err [
	^ self ffiCall: #(   ulong ERR_get_error(void))

]

{ #category : #accessing }
LibCryptoBignumber >> setWithByteArray: anByteArray [
  
	self prim_bn_bin2bn: anByteArray withLen:  anByteArray size. 

]

{ #category : #accessing }
LibCryptoBignumber >> setWithInteger: anInteger [

  self setWithByteArray:  anInteger asByteArray.
	

]
