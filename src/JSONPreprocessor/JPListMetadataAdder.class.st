"
I transform dictionaries contained by arrays to add some useful metadata to them.

I add the following keys:
- ""_index"" an integer being index of the dictionary in the array.
- ""_first?"" a boolean being true if the dictionary is the first in the array, else being false.
- ""_last?"" a boolean being true if the dictionary is the last in the array, else being false.
"
Class {
	#name : #JPListMetadataAdder,
	#superclass : #JPJSONVisitor,
	#category : #JSONPreprocessor
}

{ #category : #visiting }
JPListMetadataAdder >> visitArray: anArray [
	| newArray |
	newArray := super visitArray: anArray.
	newArray doWithIndex: [ :object :index |
		(object class = Dictionary)
			ifTrue: [ 
				object at: '_first?' put: (index = 1).
				object at: '_last?' put: (index = newArray size).
				object at: '_index' put: index ] ].
	^ newArray
]
