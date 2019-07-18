Class {
	#name : #JSONPreprocessor,
	#superclass : #Object,
	#instVars : [
		'baseDirectory'
	],
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JSONPreprocessor >> baseDirectory [
	^ baseDirectory
]

{ #category : #accessing }
JSONPreprocessor >> baseDirectory: anObject [
	baseDirectory := anObject
]

{ #category : #'pre-process' }
JSONPreprocessor >> preprocess: aJSONObject [
	| withFilesRead |
	withFilesRead := JPFileReader new
							preprocessor: self;
							baseDirectory: self baseDirectory;
							visit: aJSONObject.
	^ JPStringConverter new
		preprocessor: self;
		visit: withFilesRead
]

{ #category : #'pre-process' }
JSONPreprocessor >> preprocessString: aString [
	^ STONJSON toStringPretty: (self preprocess: (STONJSON fromString: aString))
]
