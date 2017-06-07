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
                        -*)
                            local option_desc
                            option_desc=$(grep " $3 " ~/.django/help_output/${COMP_WORDS[1]}.txt | sed -e 's/^.*'$3' \([,{a-zA-Z0-9_-]*}\?\).*/\1/')
                            case $option_desc in
                                {*)
                                    COMPREPLY=($(echo $option_desc | sed -e 's/{\(.*\)}/\1/' | sed -e 's/,/\n/g' | grep "^$2" | sort | awk -v ORS=\  '{ print }' | sed -e 's/ $//'))
                                    ;;
                                [[:upper:]]*)
                                    if [[ -z $2 ]]; then
                                        COMPREPLY=($option_desc)
                                    else
                                        COMPREPLY=()
                                    fi
                                    ;;
                                *)
                                    COMPREPLY=($(grep "^  -" $HOME/.django/help_output/${COMP_WORDS[1]}.txt | sed -e 's/^  .*\(--[-a-z]\+,\?\).*$/\1/' | grep "^$2" | sort| awk -v ORS=\  '{ print }' | sed -e 's/ $//'))
                                    ;;
                            esac
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
complete -F _django_completion -o default m ./manage.py manage.sh

update_helpoutput()
{
    cdw
    m help > $HOME/.dotfiles/django/help_output/help.txt
    COMMANDS=($(grep '    ' $HOME/.dotfiles/django/help_output/help.txt | sort | sed -e 's/^[[:space:]]*//' | grep "^$2" | awk -v ORS=\  '{ print }' | sed -e 's/ $//'))
    for COMMAND in ${COMMANDS}
    do
        m help $COMMAND > $HOME/.dotfiles/django/help_output/$COMMAND.txt
    done
}
