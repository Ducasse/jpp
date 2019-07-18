Extension { #name : #Dictionary }

{ #category : #'*JSONPreprocessor' }
Dictionary >> acceptVisitor: aJPVisitor [
	^ aJPVisitor visitDictionary: self
]
