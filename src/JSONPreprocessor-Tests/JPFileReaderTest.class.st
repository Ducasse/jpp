"
A JPFileReaderTest is a test class for testing the behavior of JPFileReader
"
Class {
	#name : #JPFileReaderTest,
	#superclass : #TestCase,
	#instVars : [
		'dictionaryForTest',
		'baseDirectory',
		'fileReader'
	],
	#category : #'JSONPreprocessor-Tests'
}

{ #category : #running }
JPFileReaderTest >> setUp [
	super setUp.
	baseDirectory := FileLocator imageDirectory.
	dictionaryForTest := { 
		'x' -> 42.
		'relative' -> { '_read_file' -> (Path * 'foo' / 'bar.txt') pathString } asDictionary.
		'absolute' -> { '_read_file' -> (baseDirectory / 'foo' / 'bar.txt') pathString } asDictionary.
		'y' -> 'a String'
	} asDictionary.
	fileReader := JPFileReader new
						baseDirectory: baseDirectory;
						yourself.
	self setUpFilesForTests
]

{ #category : #running }
JPFileReaderTest >> setUpFilesForTests [
	(baseDirectory / 'foo') createDirectory.
	(baseDirectory / 'foo' / 'bar.txt') writeStreamDo: [ :s |
		s nextPutAll: 'file_contents' ].
]

{ #category : #running }
JPFileReaderTest >> tearDown [
	(baseDirectory / 'foo' / 'bar.txt') ensureDelete.
	(baseDirectory / 'foo') ensureDelete.
	super tearDown
]

{ #category : #tests }
JPFileReaderTest >> testVisit [
	| resultDict |
	resultDict := fileReader visit: dictionaryForTest.
	self assert: resultDict equals: { 
		'x' -> 42.
		'relative' -> 'file_contents'.
		'absolute' -> 'file_contents'.
		'y' -> 'a String'
	} asDictionary
]
