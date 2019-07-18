Extension { #name : #Integer }

{ #category : #'*JSONPreprocessor' }
Integer >> acceptVisitor: aJPVisitor [
	^ aJPVisitor visitInteger: self
]
