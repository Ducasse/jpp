Extension { #name : #Array }

{ #category : #'*JSONPreprocessor' }
Array >> acceptVisitor: aJPVisitor [
	^ aJPVisitor visitArray: self
]
