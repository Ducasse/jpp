"
A JSONPreprocessorTest is a test class for testing the behavior of JSONPreprocessor
"
Class {
	#name : #JSONPreprocessorTest,
	#superclass : #TestCase,
	#category : #'JSONPreprocessor-Tests'
}

{ #category : #test }
JSONPreprocessorTest >> testPreprocess [
	| result |
	result := String streamContents: [ :writeStream |
		'{"_format" : "bbcode", "_string" : "[b]Bonjour[/b]"}' readStreamDo: [ :readStream |
			JSONPreprocessor new
				addVisitor: (JPStringConverter bbCodeExporterClass: BBCHTMLExporter);
				inputStream: readStream;
				outputStream: writeStream;
				preprocess
		] ].

	self assert: result equals: '"<b>Bonjour</b>"'
]

{ #category : #test }
JSONPreprocessorTest >> testPreprocessStringJSONFormattedStringConverter [
	| preprocessor |
	preprocessor := JSONPreprocessor new
							addVisitor: JPStringConverter new;
							yourself.
	self
		assert: (preprocessor preprocess:
			{'json_as_string' -> { '_string' -> '{"foo" : 42, "bar" : "yes"}' . '_format' -> 'json'} asDictionary} asDictionary)
		equals: {'json_as_string' -> { 'foo' -> 42. 'bar' -> 'yes' } asDictionary } asDictionary
]

{ #category : #test }
JSONPreprocessorTest >> testPreprocessStringListMetadata [
	| preprocessor |
	preprocessor := JSONPreprocessor new
							addVisitor: JPListMetadataAdder new;
							yourself.
	self
		assert: (preprocessor preprocess: {
			{'name' -> 'Julien'. 'age' -> 25} asDictionary.
			{'name' -> 'Alexandre'. 'age' -> 22} asDictionary 
		})
		equals: {
			{'name' -> 'Julien'. 'age' -> 25. '_first?' -> true. '_last?' -> false. '_index' -> 1} asDictionary.
			{'name' -> 'Alexandre'. 'age' -> 22. '_first?' -> false. '_last?' -> true. '_index' -> 2} asDictionary
		}
]
