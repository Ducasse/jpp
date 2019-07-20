Class {
	#name : #JPVisitor,
	#superclass : #Object,
	#instVars : [
		'preprocessor'
	],
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPVisitor >> preprocessor [
	^ preprocessor
]

{ #category : #accessing }
JPVisitor >> preprocessor: anObject [
	preprocessor := anObject
]

{ #category : #visiting }
JPVisitor >> visit: anObject [
	^ anObject acceptVisitor: self
]

{ #category : #visiting }
JPVisitor >> visitArray: aArray [
	^ aArray collect: [ :object | self visit: object ]
]

{ #category : #visiting }
JPVisitor >> visitBoolean: aBoolean [
	^ aBoolean copy
]

{ #category : #visiting }
JPVisitor >> visitDictionary: aDictionary [
	^ aDictionary collect: [ :object | self visit: object ]
]

{ #category : #visiting }
JPVisitor >> visitFloat: aFloat [
	^ aFloat copy
]

{ #category : #visiting }
JPVisitor >> visitInteger: aInteger [
	^ aInteger copy
]

{ #category : #visiting }
JPVisitor >> visitString: aString [
	^ aString copy
]

{ #category : #visiting }
JPVisitor >> visitUndefinedObject: aUndefinedObject [
	^ aUndefinedObject copy
]
