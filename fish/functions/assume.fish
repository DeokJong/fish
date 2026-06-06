function assume
    set -lx GRANTED_ALIAS_CONFIGURED true
    set -l granted_output (assumego $argv)
    set -l granted_status $status

    test $granted_status -eq 0 || return $granted_status

    set -l parts (string split ' ' -- (string trim -- $granted_output))
    set -l flag $parts[1]

    set -l aws_vars \
        AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN \
        AWS_PROFILE AWS_REGION AWS_DEFAULT_REGION \
        AWS_SESSION_EXPIRATION AWS_CREDENTIAL_EXPIRATION \
        GRANTED_SSO GRANTED_SSO_START_URL GRANTED_SSO_ROLE_NAME \
        GRANTED_SSO_REGION GRANTED_SSO_ACCOUNT_ID GRANTED_COMMAND

    if contains -- $flag GrantedAssume GrantedDesume
        for var in $aws_vars
            set -ge $var
        end
    end

    test $flag = GrantedAssume || return 0

    set -l keys \
        AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN \
        AWS_PROFILE AWS_REGION \
        AWS_SESSION_EXPIRATION \
        GRANTED_SSO GRANTED_SSO_START_URL GRANTED_SSO_ROLE_NAME \
        GRANTED_SSO_REGION GRANTED_SSO_ACCOUNT_ID

    for i in (seq (count $keys))
        set -l idx (math $i + 1)
        set -l val $parts[$idx]
        test -n "$val"; and test $val != None || continue
        set -gx $keys[$i] $val
        # mirror region into both vars
        if test $keys[$i] = AWS_REGION
            set -gx AWS_DEFAULT_REGION $val
        end
        if test $keys[$i] = AWS_SESSION_EXPIRATION
            set -gx AWS_CREDENTIAL_EXPIRATION $val
        end
    end

    set -gx GRANTED_COMMAND "$argv"
end
