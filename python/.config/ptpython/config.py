# convenient imports to have in every python shell
import os
import sys
import time
from pprint import pprint


def configure(repl):
    # ptpython config
    repl.vi_mode = True
    repl.confirm_exit = False
    repl.enable_mouse_support = True
    repl.highlight_matching_parenthesis = True
    repl.complete_while_typing = True
