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
	stdinString := (ZnCharacterReadStream
		on: Stdio stdin
		encoding: 'utf8') upToEnd.
	self stdout nextPutAll: stdinString.
	self stdout
		nextPutAll: (JSONPreprocessor new
							baseDirectory: FileLocator workingDirectory;
							preprocessString: stdinString)
]
