
function __complete_projectadmin
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /home/j/.local/share/go/bin/projectadmin
end
complete -f -c projectadmin -a "(__complete_projectadmin)"

