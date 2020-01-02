Class {
	#name : #JPConverter,
	#superclass : #Object,
	#instVars : [
		'stringConverter'
	],
	#category : #JSONPreprocessor
}

{ #category : #'instance creation' }
JPConverter class >> fromKey: aString [
	^ (self allSubclasses detect: [ :c | c key = aString ]) new
]

{ #category : #'instance creation' }
JPConverter class >> fromKey: aString stringConverter: stringConverter [
	^ (self fromKey: aString)
		stringConverter: stringConverter;
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
JPConverter >> stringConverter [
	^ stringConverter
]

{ #category : #accessing }
JPConverter >> stringConverter: anObject [
	stringConverter := anObject
]
