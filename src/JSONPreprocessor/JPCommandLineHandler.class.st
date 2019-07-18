Class {
	#name : #JPCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #JSONPreprocessor
}

{ #category : #accessing }
JPCommandLineHandler class >> commandName [
	^ 'jpp'
]

{ #category : #activation }
JPCommandLineHandler >> activate [
	| stdinString |
	stdinString := self stdin upToEnd.
	self stdout
		nextPutAll:
			(JSONPreprocessor new
				baseDirectory: self baseDirectory;
				preprocessString: stdinString).
	self exitSuccess
]

{ #category : #accessing }
JPCommandLineHandler >> baseDirectory [
	^ self optionAt: 'base-directory' ifAbsent: [ FileLocator workingDirectory ]
]

{ #category : #activation }
JPCommandLineHandler >> stdin [
	^ ZnCharacterReadStream on: Stdio stdin encoding: 'utf8'
]
