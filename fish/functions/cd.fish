function cd
    if test (count $argv) -eq 1 -a -f $argv[1]
        builtin cd (dirname $argv[1])
    else
        builtin cd $argv
    end
end
