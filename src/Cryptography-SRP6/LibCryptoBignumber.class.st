Class {
	#name : #LibCryptoBignumber,
	#superclass : #Object,
	#instVars : [
		'pointerToBN',
		'pointerToCtx'
	],
	#category : #'Cryptography-SRP6-LibCrytpoC'
}

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
LibCryptoBignumber >> moduloExponent: exponentBignumber modulo: moduloBignumber [

	| returnValueCCheck answer |
	answer := self class new.
	returnValueCCheck := self
		               prim_bn_mod_exp_WithResultIn: answer primPointer
		               p: exponentBignumber primPointer
		               m: moduloBignumber primPointer
		               ctx: pointerToCtx.
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
LibCryptoBignumber >> prim_bl_free [
	self ffiCall: #( void BN_free(void* pointerToBN) )  
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bl_new [
	^self ffiCall: #(  void* BN_new (void) )

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
LibCryptoBignumber >> prim_bn_mod_exp_WithResultIn: result p: p m: m ctx: ctx [
  "Call primitive. Note that the answer is an integer or C type Boolean. 1 or true
   is a success."
	^ self ffiCall: #(  int BN_mod_exp(void *result, void *pointerToBN,  void *p,
         void *m, void *ctx) )
]

{ #category : #'private - primitives' }
LibCryptoBignumber >> prim_bn_new [
	^ self ffiCall: #(  void* BN_new (void) )

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
