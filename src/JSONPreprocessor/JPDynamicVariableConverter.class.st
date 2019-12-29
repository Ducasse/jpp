Class {
	#name : #JPDynamicVariableConverter,
	#superclass : #JPConverter,
	#instVars : [
		'variableToBlock'
	],
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPDynamicVariableConverter class >> key [
	^ 'variable'
]

{ #category : #actions }
JPDynamicVariableConverter >> convert: aString [
	^ (self variableToBlock
		at: aString
		ifAbsent: [ [ aString ] ]) value
]

{ #category : #initialization }
JPDynamicVariableConverter >> initialize [
	super initialize.
	self variableToBlock: { 
		'today' -> [ Date today ddmmyyyy ] } asDictionary.
]

{ #category : #accessing }
JPDynamicVariableConverter >> variableToBlock [
	^ variableToBlock
]

{ #category : #accessing }
JPDynamicVariableConverter >> variableToBlock: anObject [
	variableToBlock := anObject
]
