Class {
	#name : #BaselineOfJSONPreprocessor,
	#superclass : #BaselineOf,
	#category : #BaselineOfJSONPreprocessor
}

{ #category : #baselines }
BaselineOfJSONPreprocessor >> baseline: spec [
	<baseline>
	<baseline>
	spec
		for: #common
			do: [
				"Packages"
				spec
					package: 'JSONPreprocessor';
					package: 'JSONPreprocessor-Tests' with: [ spec requires: #('JSONPreprocessor') ] ]
]
