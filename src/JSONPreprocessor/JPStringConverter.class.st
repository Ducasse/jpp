"
I search for dictionaries with the keys ""_format"" and ""_string"" (only!) and convert them to a single JSON object by formatting the given _string using the _format specified.

For example, 

{ ""_format"" : ""json"", ""_string"" : ""{ \""foo\"" : [1, 2, 3]}"" }

is converted as:

{ ""foo"" : [1, 2, 3]}

Another example:

{ ""_format"" : ""bbcode"", ""_string"" : ""[b]Hello[/b]"" }

is converted as:

""<b>Hello</b>""
"
Class {
	#name : #JPStringConverter,
	#superclass : #JPJSONVisitor,
	#instVars : [
		'bbCodeExporterClass'
	],
	#category : #JSONPreprocessor
}

{ #category : #'instance creation' }
JPStringConverter class >> bbCodeExporterClass: bbCodeExporterClass [
	^ self new
		bbCodeExporterClass: bbCodeExporterClass;
		yourself
]

{ #category : #accessing }
JPStringConverter >> bbCodeExporterClass [
	^ bbCodeExporterClass
]

{ #category : #accessing }
JPStringConverter >> bbCodeExporterClass: anObject [
	bbCodeExporterClass := anObject
]

{ #category : #accessing }
JPStringConverter >> formatKey [
	^ '_format'
]

{ #category : #accessing }
JPStringConverter >> stringKey [
	^ '_string'
]

{ #category : #visiting }
JPStringConverter >> visitDictionary: aDictionary [
	| converter |
	aDictionary keys asSet = (Set with: self formatKey with: self stringKey)
		ifFalse: [ ^ super visitDictionary: aDictionary ].

	converter := JPConverter fromKey: (aDictionary at: self formatKey) stringConverter: self.
	^ self visit: (self preprocessor preprocess: (converter convert: (aDictionary at: self stringKey)))
]
