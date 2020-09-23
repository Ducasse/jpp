from jpp import jpp

import pytest

def test_DynamicVariableConverter():
    converter = jpp.DynamicVariableConverter()
    converter.add_variable("today", lambda : "01/01/2020")

    assert len(converter.variables) == 1
    assert converter.convert("today") == "01/01/2020"
    assert converter.convert("nope") == "nope"

def test_JSONConverter():
    converter = jpp.JSONConverter()

    assert converter.convert("{ \"foo\" : 42 }") == { "foo" : 42 }

def test_NoneConverter():
    converter = jpp.NoneConverter()
    
    assert converter.convert("foo") == "foo"

def test_ConvertersRegistry():
    registry = jpp.ConvertersRegistry()
    json_converter = jpp.JSONConverter()

    registry.register("json", json_converter)

    assert "json" in registry.keys
    assert json_converter in registry.converters
    assert registry.converter_with_key("json") == json_converter

def test_FormatVisitor():
    preprocessor = jpp.JSONPreProcessor(None, None)
    registry = jpp.ConvertersRegistry()
    registry.register("json", jpp.JSONConverter())

    visitor = jpp.FormatVisitor(registry, preprocessor)

    input_dict = { "_format" : "json", "_string" : "{ \"foo\" : 42 }" }
    output_dict = visitor.visit(input_dict)

    assert output_dict == { "foo" : 42 }

def test_ListMetadataAdder():
    preprocessor = jpp.JSONPreProcessor(None, None)
    registry = jpp.ConvertersRegistry()
    registry.register("json", jpp.JSONConverter())

    visitor = jpp.ListMetadataAdder(preprocessor)

    input_dict = { "list" : [
        {
            "name" : "first"
        },
        {
            "name" : "second"
        },
        {
            "name" : "third"
        }
    ] }
    output_dict = visitor.visit(input_dict)

    print(output_dict)

    assert output_dict == { "list" : [
        {
            "name" : "first",
            "_index" : 1,
            "_first?" : True,
            "_last?" : False
        },
        {
            "name" : "second",
            "_index" : 2,
            "_first?" : False,
            "_last?" : False
        },
        {
            "name" : "third",
            "_index" : 3,
            "_first?" : False,
            "_last?" : True
        }
    ] }