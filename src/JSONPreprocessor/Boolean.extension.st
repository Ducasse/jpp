Extension { #name : #Boolean }

{ #category : #'*JSONPreprocessor' }
Boolean >> acceptVisitor: aJPVisitor [
	^ aJPVisitor visitBoolean: self
]
