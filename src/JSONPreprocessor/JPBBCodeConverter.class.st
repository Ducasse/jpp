Class {
	#name : #JPBBCodeConverter,
	#superclass : #JPConverter,
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPBBCodeConverter class >> key [
	^ 'bbcode'
]

{ #category : #actions }
JPBBCodeConverter >> convert: aString [
	^ String streamContents: [ :writeStream |
	| export |
	export := BBCHTMLExporter new
					writeStream: writeStream.
	[ (BBCParser new
		parse: aString readStream) accept: export.
	] on: BBCBadFormat do: [ :error |
		error messageText = 'Not a bbcode string.'
			ifTrue: [ ^ aString ].
		self error: ('Malformated BBCode: "{1}"' format: { aString }) ] ]
]
