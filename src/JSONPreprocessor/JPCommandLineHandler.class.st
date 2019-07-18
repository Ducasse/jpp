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
	self stdout nextPutAll: stdinString.
	self stdout
		nextPutAll:
			(JSONPreprocessor new
				baseDirectory: FileLocator workingDirectory;
				preprocessString: stdinString).
	self exitSuccess
]

{ #category : #activation }
JPCommandLineHandler >> stdin [
	^ ZnCharacterReadStream on: Stdio stdin encoding: 'utf8'
]
