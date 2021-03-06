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
		[ self buildPreprocessor preprocess.
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
		ifAbsent: [ 
			^ self hasInputFile
				ifTrue: [ self inputFileReference parent ]
				ifFalse: [ FileLocator workingDirectory ] ].
	^ self convertPathStringToFileReference: baseDir
]

{ #category : #accessing }
JPCommandLineHandler >> bbCodeExporterClass [
	| exporterName |
	exporterName := self
		optionAt: 'bbcode-exporter'
		ifAbsent: [ ^ BBCHTMLExporter ].
	^ self exporterClassForName: exporterName
]

{ #category : #activation }
JPCommandLineHandler >> buildPreprocessor [
	^ JSONPreprocessor new
		inputStream: self inputStream;
		outputStream: self outputStream;
		addVisitor: (JPFileReader baseDirectory: self baseDirectory);
		addVisitor: (JPStringConverter bbCodeExporterClass: self bbCodeExporterClass);
		addVisitor: JPListMetadataAdder new;
		yourself
]

{ #category : #private }
JPCommandLineHandler >> convertPathStringToFileReference: pathString [
	^ pathString first = $/
		ifTrue: [ pathString asFileReference ]
		ifFalse: [ FileLocator workingDirectory / pathString ]
]

{ #category : #accessing }
JPCommandLineHandler >> exporterClassForName: exporterName [
	^ { 
		'html' -> BBCHTMLExporter.
		'latex' -> BBCLaTeXExporter
	 } asDictionary at: exporterName
]

{ #category : #testing }
JPCommandLineHandler >> hasInputFile [
	^ self positionalArguments size >= 1
		and:[ (self positionalArgumentAt: 1) ~= self stdinoutPathStringConvention ]
]

{ #category : #testing }
JPCommandLineHandler >> hasOutputFile [
	^ self positionalArguments size >= 2
		and: [ (self positionalArgumentAt: 2) ~= self stdinoutPathStringConvention ]
]

{ #category : #accessing }
JPCommandLineHandler >> inputFileReference [
	^ self convertPathStringToFileReference: (self positionalArgumentAt: 1)
]

{ #category : #accessing }
JPCommandLineHandler >> inputStream [
	self hasInputFile
		ifFalse: [ ^ self stdin ].
	
	^ self inputFileReference readStream
]

{ #category : #accessing }
JPCommandLineHandler >> inputString [
	^ self inputStream upToEnd
]

{ #category : #accessing }
JPCommandLineHandler >> outputStream [
	self hasOutputFile
		ifFalse: [ ^ self stdout ].
	^ (self
		convertPathStringToFileReference: (self positionalArgumentAt: 2))
		writeStream
]

{ #category : #accessing }
JPCommandLineHandler >> positionalArgumentAt: anIndex [
	^ self positionalArguments at: anIndex
]

{ #category : #accessing }
JPCommandLineHandler >> positionalArguments [
	^ self arguments reject: [ :arg |
		((arg beginsWith: '--') and: [ arg size > 2 ]) or: [ 
			(arg beginsWith: '-') and: [ arg size > 1 ] ] ]
]

{ #category : #accessing }
JPCommandLineHandler >> stdin [
	^ ZnCharacterReadStream on: Stdio stdin encoding: 'utf8'
]

{ #category : #accessing }
JPCommandLineHandler >> stdinoutPathStringConvention [
	^ '-'
]
