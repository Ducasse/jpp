#!/usr/bin/env python3
"""JPP (╯°□°)╯︵ ┻━┻
The Json Pre-Processor.


Usage:
  jpp.py [<input-file>] [<output-file>] [--base-directory=<directory>] [--bbcode-exporter=<exporter>] [--pretty-print]
  jpp.py (-h | --help)
  jpp.py --version

Options:
  -h --help                     Show this screen.
  --version                     Show version.
  --base-directory=<directory>  Set the base directory to be used when using relative path to load file content.
  --pretty-print                Resulting JSON is pretty-printed (indentation, dictionary ordered by keys).
  --bbcode-exporter=<exporter>  Sets the exporter to be used for BBCode.
"""

from abc import ABCMeta, abstractmethod
import json
import bbcode
import visitor
import os

class Converter(object, metaclass=ABCMeta):
    @abstractmethod
    def convert(self, string):
        pass

def bbcode_formater_for_html(string):
    return bbcode.render_html(string)

def bbcode_formater_for_latex(string):
    
    return parser


class BBCodeConverter(Converter):
    def __init__(self, bbcode_formatter=bbcode_formater_for_html):
        self.bbcode_formatter = bbcode_formatter

    def convert(self, string):
        return self.bbcode_formatter(string)

class DynamicVariable(object):
    def __init__(self, name, function):
        self.name = name
        self.function = function

class DynamicVariableConverter(Converter):
    def __init__(self):
        self.variables = []
    
    def add_variable(self, name, function):
        self.variables.append(DynamicVariable(name, function))
    
    def convert(self, string):
        for variable in self.variables:
            if string == variable.name:
                return variable.function()
        return string

class JSONConverter(Converter):
    """ I convert the string I receive as a JSON object and returns it.
    """
    def convert(self, string):
        return json.loads(string)

class NoneConverter(Converter):
    """ I am the implementation of the null object design pattern for a
        converter.
    
        I just return the string as I receive it, without any transformation.
    """
    def convert(self, string):
        return string

class ConvertersRegistry(object):
    def __init__(self):
        self.registry_dict = dict()
    
    def converter_with_key(self, key):
        return self.registry_dict[key]
    
    def register(self, key, converter):
        self.registry_dict[key] = converter
    
    @property
    def keys(self):
        return self.registry_dict.keys()
    
    @property
    def converters(self):
        return self.registry_dict.values()

# default_converters_registry = ConvertersRegistry()

# def register_converter(key, converter):
#     global default_converters_registry
#     default_converters_registry[key] = converter

class JSONVisitor(visitor.Visitor):
    def __init__(self, preprocessor, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.preprocessor = preprocessor

    def preprocess(self, obj):
        return self.preprocessor.preprocess_object(obj)

    def visit_list(self, l):
        new_list = list()
        for obj in l:
            new_list.append(self.visit(obj))
        return new_list
    
    def visit_bool(self, boolean):
        return boolean
    
    def visit_dict(self, dictionary):
        new_dict = dict()
        for key, obj in dictionary.items():
            new_dict[key] = self.visit(obj)
        return new_dict
    
    def visit_float(self, f):
        return f
    
    def visit_int(self, integer):
        return integer
    
    def visit_str(self, string):
        return string
    
    def visit_NoneType(self, none):
        return none

class FormatVisitor(JSONVisitor):
    def __init__(self, converters_registry, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.converters_registry = converters_registry
    
    def converter_for_key(self, key):
        return self.converters_registry.converter_with_key(key)

    def visit_dict(self, dictionary):
        if dictionary.keys() != { "_string", "_format" }:
            return super().visit_dict(dictionary)
        
        format_key = dictionary["_format"]
        string_to_convert = dictionary["_string"]
        converter = self.converter_for_key(format_key)
        return self.visit(self.preprocess(converter.convert(string_to_convert)))

class ListMetadataAdder(JSONVisitor):
    """Transform dictionaries contained by arrays by adding metadata to them.

    The following keys are added:
        - "_index" an integer being index of the dictionary in the array.
        - "_first?" a boolean being true if the dictionary is the first in the
        array, else being false.
        - "_last?" a boolean being true if the dictionary is the last in the
        array, else being false.
    """
    def visit_list(self, l):
        new_list = super().visit_list(l)
        for index, obj in enumerate(new_list):
            if type(obj) == dict:
                obj["_first?"] = (index == 0)
                obj["_last?"] = (index == len(new_list) - 1)
                obj["_index"] = (index + 1) # TODO: in the future maybe let user configure indexing
        return new_list

class FileReader(JSONVisitor):
    def __init__(self, base_directory, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.base_directory = base_directory
    
    def visit_dict(self, dictionary):
        if dictionary.keys() != { "_read_file" }:
            return super().visit_dict(dictionary)
        
        path = dictionary["_read_file"]

        # In case of absolute path, inject the content in the json object.
        if not os.path.isabs(path):
            path = os.path.join(self.base_directory, path)

        with open(path, "r") as f:
            return f.read()

class JSONPreProcessor(object):
    def __init__(self, input_stream, output_stream, visitors=[], json_output_config={}, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.visitors = visitors
        self.input_stream = input_stream
        self.output_stream = output_stream
        self.json_output_config = json_output_config
    
    def add_visitor(self, visitor):
        self.visitors.append(visitor)
    
    def preprocess_object(self, jsonObject):
        resulting_obj = jsonObject
        for visitor in self.visitors:
            resulting_obj = visitor.visit(resulting_obj)
        return resulting_obj
    
    def preprocess(self):
        preprocessed_obj = self.preprocess_object(json.load(self.input_stream))
        json.dump(preprocessed_obj, self.output_stream, **json_output_config)

if __name__ == "__main__":
    from docopt import docopt
    import sys
    from datetime import date
    arguments = docopt(__doc__, version='JPP 1.0')

    input_stream = arguments["<input-file>"]
    output_stream = arguments["<output-file>"]
    base_directory = arguments["--base-directory"]
    json_output_config = dict()

    if input_stream:
        input_stream = open(input_stream, "r")
    else:
        input_stream = sys.stdin
    
    if output_stream:
        output_stream = open(output_stream, "w", encoding='utf8')
    else:
        output_stream = sys.stdout
    
    if not base_directory:
        base_directory = os.getcwd()
    
    if arguments["--pretty-print"]:
        json_output_config = {
            "sort_keys" : True,
            "indent" : 4,
            "ensure_ascii" : False
        }
        
    
    preprocessor = JSONPreProcessor(
        input_stream,
        output_stream,
        json_output_config=json_output_config
    )
    preprocessor.add_visitor(FileReader(base_directory, preprocessor))

    registry = ConvertersRegistry()
    registry.register("json", JSONConverter())
    variable_converter = DynamicVariableConverter()
    variable_converter.add_variable("today", lambda : date.today().strftime("%d/%m/%Y"))
    registry.register("variable", variable_converter)
    registry.register("bbcode", BBCodeConverter())
    format_visitor = FormatVisitor(registry, preprocessor)
    preprocessor.add_visitor(format_visitor)

    preprocessor.add_visitor(ListMetadataAdder(preprocessor))
    preprocessor.preprocess()
