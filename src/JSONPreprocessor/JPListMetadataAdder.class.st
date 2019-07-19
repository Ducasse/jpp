Class {
	#name : #JPListMetadataAdder,
	#superclass : #JPVisitor,
	#category : #JSONPreprocessor
}

{ #category : #visiting }
JPListMetadataAdder >> visitArray: anArray [
	| newArray |
	newArray := super visitArray: anArray.
	newArray doWithIndex: [ :object :index |
		(object class = Dictionary)
			ifTrue: [ object at: '_last?' put: (index = newArray size) ] ].
	^ newArray
]
