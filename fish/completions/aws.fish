complete --command aws --no-files --arguments '(
    set -lx COMP_SHELL fish
    set -lx COMP_LINE (commandline)
    set -lx COMP_POINT (string length (commandline))
    aws_completer
)'
