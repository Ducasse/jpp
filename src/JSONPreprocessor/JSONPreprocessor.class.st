Class {
	#name : #JSONPreprocessor,
	#superclass : #Object,
	#instVars : [
		'baseDirectory',
		'visitors'
	],
	#category : #JSONPreprocessor
}

{ #category : #adding }
JSONPreprocessor >> addVisitor: aVisitor [
	aVisitor preprocessor: self.
	self visitors add: aVisitor
]

{ #category : #accessing }
JSONPreprocessor >> baseDirectory [
	^ baseDirectory
]

{ #category : #accessing }
JSONPreprocessor >> baseDirectory: anObject [
	baseDirectory := anObject
]

{ #category : #initialization }
JSONPreprocessor >> initialize [
	super initialize.
	"self visitors: {
		JPFileReader new
			preprocessor: self;
			baseDirectory: self baseDirectory;
			yourself.
		JPStringConverter new
			preprocessor: self;
			yourself.
		JPListMetadataAdder new
			preprocessor: self;
			yourself }."
	self visitors: OrderedCollection new
]

{ #category : #'pre-process' }
JSONPreprocessor >> preprocess: aJSONObject [
	^ self visitors
		inject: aJSONObject
		into: [ :dict :visitor |
			visitor visit: dict ]
]

{ #category : #'pre-process' }
JSONPreprocessor >> preprocessString: aString [
	^ STONJSON toStringPretty: (self preprocess: (STONJSON fromString: aString))
]

{ #category : #accessing }
JSONPreprocessor >> visitors [
	^ visitors
]

{ #category : #accessing }
JSONPreprocessor >> visitors: anObject [
	visitors := anObject
]
