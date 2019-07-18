"
A JPJSONConverterTest is a test class for testing the behavior of JPJSONConverter
"
Class {
	#name : #JPJSONConverterTest,
	#superclass : #TestCase,
	#category : #'JSONPreprocessor-Tests'
}

{ #category : #test }
JPJSONConverterTest >> testConvert [
	| converted |
	converted := JPJSONConverter new convert: '{ "x" : 42 }'.
	self assert: converted equals: { 'x' -> 42 } asDictionary
]

{ #category : #test }
JPJSONConverterTest >> testFromKey [
	self assert: (JPConverter fromKey: 'json') class equals: JPJSONConverter
]
