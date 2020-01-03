"
I am a visitor for a JSON object.

I just recursively copy the JSON which is a convenient default behavior to be used as a basis by my suclasses.

My subclasses probably implement transformation of the JSON object according to some rules.
"
Class {
	#name : #JPJSONVisitor,
	#superclass : #Object,
	#instVars : [
		'preprocessor'
	],
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPJSONVisitor >> preprocessor [
	^ preprocessor
]

{ #category : #accessing }
JPJSONVisitor >> preprocessor: anObject [
	preprocessor := anObject
]

{ #category : #visiting }
JPJSONVisitor >> visit: anObject [
	^ anObject acceptVisitor: self
]

{ #category : #visiting }
JPJSONVisitor >> visitArray: aArray [
	^ aArray collect: [ :object | self visit: object ]
]

{ #category : #visiting }
JPJSONVisitor >> visitBoolean: aBoolean [
	^ aBoolean copy
]

{ #category : #visiting }
JPJSONVisitor >> visitDictionary: aDictionary [
	^ aDictionary collect: [ :object | self visit: object ]
]

{ #category : #visiting }
JPJSONVisitor >> visitFloat: aFloat [
	^ aFloat copy
]

{ #category : #visiting }
JPJSONVisitor >> visitInteger: aInteger [
	^ aInteger copy
]

{ #category : #visiting }
JPJSONVisitor >> visitString: aString [
	^ aString copy
]

{ #category : #visiting }
JPJSONVisitor >> visitUndefinedObject: aUndefinedObject [
	^ aUndefinedObject copy
]
