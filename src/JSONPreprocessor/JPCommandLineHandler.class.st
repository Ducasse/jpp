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
	[
		[ self outputStream
			nextPutAll:
				(JSONPreprocessor new
					baseDirectory: self baseDirectory;
					preprocessString: self inputString).
		self exitSuccess ] on: Error do: [ :error |
			self stderr
				nextPutAll: ('Error: {1}' format: { error messageText }).
			self exitFailure ].
	] ensure: [
		self inputStream close.
		self outputStream close.
	].
]

{ #category : #accessing }
JPCommandLineHandler >> baseDirectory [
	| baseDir |
	baseDir := self optionAt: 'base-directory' ifAbsent: [ ^ FileLocator workingDirectory ].
	^ (baseDir first = $/)
		ifTrue: [ baseDir asFileReference ]
		ifFalse: [ FileLocator workingDirectory / baseDir ]
]

{ #category : #accessing }
JPCommandLineHandler >> inputStream [
	^ self stdin
]

{ #category : #accessing }
JPCommandLineHandler >> inputString [
	^ self inputStream upToEnd
]

{ #category : #accessing }
JPCommandLineHandler >> outputStream [
	^ self stdout
]

{ #category : #accessing }
JPCommandLineHandler >> stdin [
	^ ZnCharacterReadStream on: Stdio stdin encoding: 'utf8'
]
