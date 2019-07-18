Extension { #name : #String }

{ #category : #'*JSONPreprocessor' }
String >> acceptVisitor: aJPVisitor [
	^ aJPVisitor visitString: self
]
