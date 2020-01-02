Class {
	#name : #JPBBCodeConverter,
	#superclass : #JPConverter,
	#instVars : [
		'exporterClass'
	],
	#category : #JSONPreprocessor
}

{ #category : #'instance creation' }
JPBBCodeConverter class >> exporterClass: exporterClass [
	^ self new
		exporterClass: exporterClass;
		yourself
]

{ #category : #accessing }
JPBBCodeConverter class >> key [
	^ 'bbcode'
]

{ #category : #actions }
JPBBCodeConverter >> convert: aString [
	^ String streamContents: [ :writeStream |
	| export |
	export := self exporterClass new
					writeStream: writeStream.
	[ (BBCParser new
		parse: aString readStream) accept: export.
	] on: BBCBadFormat do: [ :error |
		error messageText = 'Not a bbcode string.'
			ifTrue: [ ^ aString ].
		self error: ('Malformated BBCode: "{1}"' format: { aString }) ] ]
]

{ #category : #accessing }
JPBBCodeConverter >> exporterClass [
	^ exporterClass
]

{ #category : #accessing }
JPBBCodeConverter >> exporterClass: anObject [
	exporterClass := anObject
]
