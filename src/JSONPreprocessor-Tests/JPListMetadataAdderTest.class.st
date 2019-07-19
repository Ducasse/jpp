"
A JPListMetadataAdderTest is a test class for testing the behavior of JPListMetadataAdder
"
Class {
	#name : #JPListMetadataAdderTest,
	#superclass : #TestCase,
	#instVars : [
		'testDict',
		'metadataAdder'
	],
	#category : #'JSONPreprocessor-Tests'
}

{ #category : #running }
JPListMetadataAdderTest >> setUp [
	super setUp.
	testDict := { 'list' -> { 
		{ 'name' -> 'first' } asDictionary.
		{ 'name' -> 'second' } asDictionary.
		{ 'name' -> 'third' } asDictionary 
	} } asDictionary.
	
	metadataAdder := JPListMetadataAdder new.
]

{ #category : #tests }
JPListMetadataAdderTest >> testVisit [
	| result |
	result := metadataAdder visit: testDict.
	self assert: result equals: { 'list' -> { 
		{ 'name' -> 'first'. '_last?' -> false } asDictionary.
		{ 'name' -> 'second'. '_last?' -> false } asDictionary.
		{ 'name' -> 'third'. '_last?' -> true } asDictionary 
	} } asDictionary
]
