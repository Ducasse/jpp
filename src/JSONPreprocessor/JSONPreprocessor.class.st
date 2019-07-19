Class {
	#name : #JSONPreprocessor,
	#superclass : #Object,
	#instVars : [
		'baseDirectory',
		'bbCodeExporterClass'
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

{ #category : #accessing }
JSONPreprocessor >> bbCodeExporterClass [
	^ bbCodeExporterClass
]

{ #category : #accessing }
JSONPreprocessor >> bbCodeExporterClass: anObject [
	bbCodeExporterClass := anObject
]

{ #category : #'pre-process' }
JSONPreprocessor >> preprocess: aJSONObject [
	| withFilesRead withStringPreprocessed |
	withFilesRead := JPFileReader new
							preprocessor: self;
							baseDirectory: self baseDirectory;
							visit: aJSONObject.
	withStringPreprocessed := JPStringConverter new
										preprocessor: self;
										visit: withFilesRead.
	^ JPListMetadataAdder new
		preprocessor: self;
		visit: withStringPreprocessed
]

{ #category : #'pre-process' }
JSONPreprocessor >> preprocessString: aString [
	^ STONJSON toStringPretty: (self preprocess: (STONJSON fromString: aString))
]
