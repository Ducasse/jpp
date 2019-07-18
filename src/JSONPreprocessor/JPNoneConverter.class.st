Class {
	#name : #JPNoneConverter,
	#superclass : #JPConverter,
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPNoneConverter class >> key [
	^ 'none'
]

{ #category : #actions }
JPNoneConverter >> convert: aString [
	^ aString
]
