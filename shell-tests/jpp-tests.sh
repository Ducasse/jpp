#!/bin/sh

JPP="./jpp/jpp"

testBonjour() {
	assertEquals $(echo '{"_format" : "bbcode", "_string" : "[b]Bonjour[/b]"}' | $JPP) '"<b>Bonjour</b>"'
}

. shunit2-2.1.6/src/shunit2
