Class {
	#name : #BaselineOfJSONPreprocessor,
	#superclass : #BaselineOf,
	#category : #BaselineOfJSONPreprocessor
}

{ #category : #baselines }
BaselineOfJSONPreprocessor >> baseline: spec [
	<baseline>
	spec
		for: #common
			do: [
				"Dependencies"
				spec baseline: 'BBCode' with: [ 
					spec repository: 'github://juliendelplanque/BBCode/src' ].
				"Packages"
				spec
					package: 'JSONPreprocessor' with: [ spec requires: #('BBCode') ];
					package: 'JSONPreprocessor-Tests' with: [ spec requires: #('JSONPreprocessor') ] ]
]
