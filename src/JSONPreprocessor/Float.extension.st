Extension { #name : #Float }

{ #category : #'*JSONPreprocessor' }
Float >> acceptVisitor: aJPVisitor [
	^ aJPVisitor visitFloat: self
]
