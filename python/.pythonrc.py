import sys


def configure(repl):
    repl.vi_mode = True
    repl.confirm_exit = False
    repl.enable_mouse_support = True
    repl.highlight_matching_parenthesis = True
    repl.complete_while_typing = True


try:
    from ptpython.repl import embed
except ImportError:
    print("ptpython is not available: falling back to standard prompt")
else:
    sys.exit(
        embed(
            globals(),
            locals(),
            history_filename="/Users/pault/.config/ptpython/history",
            configure=configure,
        )
    )
