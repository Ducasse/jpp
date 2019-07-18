Class {
	#name : #JPFileReader,
	#superclass : #JPVisitor,
	#instVars : [
		'baseDirectory'
	],
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPFileReader >> baseDirectory [
	^ baseDirectory
]

{ #category : #accessing }
JPFileReader >> baseDirectory: anObject [
	baseDirectory := anObject
]

{ #category : #accessing }
JPFileReader >> readFileKey [
	^ '_read_file'
]

{ #category : #visiting }
JPFileReader >> visitDictionary: aDictionary [
	| path |
	aDictionary keys asSet = (Set with: self readFileKey)
		ifFalse: [ ^ super visitDictionary: aDictionary ].
		
	path := (aDictionary at: self readFileKey).
	
	path asFileReference isAbsolute
		ifTrue: [ ^ path asFileReference contents ].
	
	^ (self baseDirectory / path) contents
]
