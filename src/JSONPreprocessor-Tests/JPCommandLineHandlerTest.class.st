"
A JPCommandLineHandlerTest is a test class for testing the behavior of JPCommandLineHandler
"
Class {
	#name : #JPCommandLineHandlerTest,
	#superclass : #TestCase,
	#category : #'JSONPreprocessor-Tests'
}

{ #category : #test }
JPCommandLineHandlerTest >> testHasInputFile [
	| handler |
	handler := JPCommandLineHandler commandLine: (CommandLineArguments withArguments: #('--bbcode-exporter=html' '--base-directory=data' '/foo/bar/data.json')).
	self assert: handler hasInputFile
]

{ #category : #test }
JPCommandLineHandlerTest >> testHasInputFile2 [
	| handler |
	handler := JPCommandLineHandler commandLine: (CommandLineArguments withArguments: #('--bbcode-exporter=html' '--base-directory=data')).
	self deny: handler hasInputFile
]

{ #category : #test }
JPCommandLineHandlerTest >> testHasInputFile3 [
	| handler |
	handler := JPCommandLineHandler commandLine: (CommandLineArguments withArguments: #('--bbcode-exporter=html' '--base-directory=data -')).
	self deny: handler hasInputFile
]

{ #category : #test }
JPCommandLineHandlerTest >> testHasOutputFile [
	| handler |
	handler := JPCommandLineHandler commandLine: (CommandLineArguments withArguments: #('--bbcode-exporter=html' '--base-directory=data' '/foo/bar/data.json' '/foo/bar/output.json')).
	self assert: handler hasOutputFile
]

{ #category : #test }
JPCommandLineHandlerTest >> testHasOutputFile2 [
	| handler |
	handler := JPCommandLineHandler commandLine: (CommandLineArguments withArguments: #('--bbcode-exporter=html' '--base-directory=data' '/foo/bar/data.json' '-')).
	self deny: handler hasOutputFile
]

{ #category : #test }
JPCommandLineHandlerTest >> testHasOutputFile3 [
	| handler |
	handler := JPCommandLineHandler commandLine: (CommandLineArguments withArguments: #('--bbcode-exporter=html' '--base-directory=data' '/foo/bar/data.json')).
	self deny: handler hasOutputFile
]
