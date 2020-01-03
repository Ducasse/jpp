"
I allow one to include the content of an external file as a String in the resulting JSON object.

Relative path to a file to include are resolved starting from my #baseDirectory.
"
Class {
	#name : #JPFileReader,
	#superclass : #JPJSONVisitor,
	#instVars : [
		'baseDirectory'
	],
	#category : #JSONPreprocessor
}

{ #category : #'instance creation' }
JPFileReader class >> baseDirectory: baseDirectory [
	^ self new
		baseDirectory: baseDirectory;
		yourself
]

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
