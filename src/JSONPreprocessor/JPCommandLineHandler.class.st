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
				nextPutAll: ('Error: {1}' format: { error description }).
			self exitFailure ].
	] ensure: [
		self inputStream close.
		self outputStream close.
	].
]

{ #category : #accessing }
JPCommandLineHandler >> baseDirectory [
	| baseDir |
	baseDir := self
		optionAt: 'base-directory'
		ifAbsent: [ ^ FileLocator workingDirectory ].
	^ self convertPathStringToFileReference: baseDir
]

{ #category : #private }
JPCommandLineHandler >> convertPathStringToFileReference: pathString [
	^ pathString first = $/
		ifTrue: [ pathString asFileReference ]
		ifFalse: [ FileLocator workingDirectory / pathString ]
]

{ #category : #accessing }
JPCommandLineHandler >> inputStream [
	(self arguments size < 1 or: [ (self argumentAt: 1) = self stdinoutPathStringConvention ])
		ifTrue: [ ^ self stdin ].
	
	^ self convertPathStringToFileReference: (self argumentAt: 1)
]

{ #category : #accessing }
JPCommandLineHandler >> inputString [
	^ self inputStream upToEnd
]

{ #category : #accessing }
JPCommandLineHandler >> outputStream [
	(self arguments size < 2 or: [ (self argumentAt: 2) = self stdinoutPathStringConvention ])
		ifTrue: [ ^ self stdout ].
		
	^ self convertPathStringToFileReference: (self argumentAt: 2)
]

{ #category : #accessing }
JPCommandLineHandler >> stdin [
	^ ZnCharacterReadStream on: Stdio stdin encoding: 'utf8'
]

{ #category : #accessing }
JPCommandLineHandler >> stdinoutPathStringConvention [
	^ '-'
]
