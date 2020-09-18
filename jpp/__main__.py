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
from docopt import docopt
import sys
from datetime import date
from jpp import *

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
