Class {
	#name : #JPStringConverter,
	#superclass : #JPVisitor,
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPStringConverter >> formatKey [
	^ '_format'
]

{ #category : #accessing }
JPStringConverter >> stringKey [
	^ '_string'
]

{ #category : #visiting }
JPStringConverter >> visitDictionary: aDictionary [
	| converter |
	aDictionary keys asSet = (Set with: self formatKey with: self stringKey)
		ifFalse: [ ^ super visitDictionary: aDictionary ].

	converter := JPConverter fromKey: (aDictionary at: self formatKey) preprocessor: self preprocessor.
	^ self visit: (self preprocessor preprocess: (converter convert: (aDictionary at: self stringKey)))
]
