Class {
	#name : #JPJSONConverter,
	#superclass : #JPConverter,
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPJSONConverter class >> key [
	^ 'json'
]

{ #category : #actions }
JPJSONConverter >> convert: aString [
	^ STONJSON fromString: aString
]
