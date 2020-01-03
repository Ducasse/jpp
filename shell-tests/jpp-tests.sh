#!/bin/sh

JPP="./jpp/jpp"

testBonjour() {
	assertEquals $(echo '{"_format" : "bbcode", "_string" : "[b]Bonjour[/b]"}' | $JPP) '"<b>Bonjour</b>"'
}

testListMetadata() {
	local input='[{"name" : "Julien", "age" : 25}, {"name" : "Alexandre", "age" : 22}]'
	read -r -d '' output << EOM
[
	{
		"_index" : 1,
		"age" : 25,
		"_last?" : false,
		"_first?" : true,
		"name" : "Julien"
	},
	{
		"_index" : 2,
		"age" : 22,
		"_last?" : true,
		"_first?" : false,
		"name" : "Alexandre"
	}
]
EOM
	assertEquals "$(echo $input | $JPP)" "$output"
}

. shunit2-2.1.6/src/shunit2
