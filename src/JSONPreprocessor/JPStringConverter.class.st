Class {
	#name : #JPStringConverter,
	#superclass : #JPVisitor,
	#instVars : [
		'bbCodeExporterClass'
	],
	#category : #JSONPreprocessor
}

{ #category : #'instance creation' }
JPStringConverter class >> bbCodeExporterClass: bbCodeExporterClass [
	^ self new
		bbCodeExporterClass: bbCodeExporterClass;
		yourself
]

{ #category : #accessing }
JPStringConverter >> bbCodeExporterClass [
	^ bbCodeExporterClass
]

{ #category : #accessing }
JPStringConverter >> bbCodeExporterClass: anObject [
	bbCodeExporterClass := anObject
]

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

	converter := JPConverter fromKey: (aDictionary at: self formatKey) stringConverter: self.
	^ self visit: (self preprocessor preprocess: (converter convert: (aDictionary at: self stringKey)))
]
