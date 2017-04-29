_django_completion()
{
    case ${COMP_CWORD} in
        1)
            COMPREPLY=($(grep '    ' $HOME/.django/help_output/help.txt | sed -e 's/^[[:space:]]*//' | awk 'BEGIN { print "help"; } { print }' | sort | grep "^$2" | awk -v ORS=\  '{ print }' | sed -e 's/ $//'))
            ;;
        *)
            case ${COMP_WORDS[1]} in
                help)
                    COMPREPLY=($(grep '    ' $HOME/.django/help_output/help.txt | sort | sed -e 's/^[[:space:]]*//' | grep "^$2" | awk -v ORS=\  '{ print }' | sed -e 's/ $//'))
                    ;;
                *)
                    case $3 in
                        --scenario*)
                            COMPREPLY=($(grep "^$2" $HOME/.django/scenarios_lists/${COMP_WORDS[1]}.txt | awk -v ORS=\  '{ print }' | sed -e 's/ $//'))
                            ;;
                        *)
                            COMPREPLY=($(grep "^  -" $HOME/.django/help_output/${COMP_WORDS[1]}.txt | sed -e 's/^  .*\(--[-a-z]\+,\?\).*$/\1/' | grep "^$2" | sort| awk -v ORS=\  '{ print }' | sed -e 's/ $//'))
                            ;;
                    esac
                    ;;
            esac
            ;;
    esac

}
complete -F _django_completion -o default m
