Class {
	#name : #JPConverter,
	#superclass : #Object,
	#instVars : [
		'preprocessor'
	],
	#category : #JSONPreprocessor
}

{ #category : #'instance creation' }
JPConverter class >> fromKey: aString [
	^ (self allSubclasses detect: [ :c | c key = aString ]) new
]

{ #category : #'instance creation' }
JPConverter class >> fromKey: aString preprocessor: aPreprocessor [
	^ (self fromKey: aString)
		preprocessor: aPreprocessor;
		yourself
]

{ #category : #accessing }
JPConverter class >> key [
	"Returns the unique key to use to refer to the converter."
	^ self subclassResponsibility
]

{ #category : #actions }
JPConverter >> convert: aString [
	^ self subclassResponsibility
]

{ #category : #accessing }
JPConverter >> preprocessor [
	^ preprocessor
]

{ #category : #accessing }
JPConverter >> preprocessor: anObject [
	preprocessor := anObject
]
