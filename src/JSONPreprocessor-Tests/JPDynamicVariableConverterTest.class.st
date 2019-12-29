"
A JPDynamicVariableConverterTest is a test class for testing the behavior of JPDynamicVariableConverter
"
Class {
	#name : #JPDynamicVariableConverterTest,
	#superclass : #TestCase,
	#category : #'JSONPreprocessor-Tests'
}

{ #category : #test }
JPDynamicVariableConverterTest >> testConvert [
	| converted |
	converted := JPDynamicVariableConverter new convert: 'today'.
	self assert: converted equals: Date today ddmmyyyy
]

{ #category : #tests }
JPDynamicVariableConverterTest >> testFromKey [
	self assert: (JPConverter fromKey: 'variable') class equals: JPDynamicVariableConverter
]
