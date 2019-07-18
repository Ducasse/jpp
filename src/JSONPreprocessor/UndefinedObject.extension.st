Extension { #name : #UndefinedObject }

{ #category : #'*JSONPreprocessor' }
UndefinedObject >> acceptVisitor: aJPVisitor [
	^ aJPVisitor visitUndefinedObject: self
]
