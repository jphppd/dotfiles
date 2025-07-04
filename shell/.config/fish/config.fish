set --global fish_greeting

fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

if status is-interactive

    # Suggest to install misc cli utils
    _check_cargo_install bat bat
    _check_cargo_install czkawka_cli czkawka_cli
    _check_cargo_install difft difftastic
    _check_cargo_install dust du-dust
    _check_cargo_install eza eza
    _check_cargo_install fd fd-find
    _check_cargo_install fend fend
    _check_cargo_install grex grex
    _check_cargo_install hx hx
    _check_cargo_install pastel pastel
    _check_cargo_install rg ripgrep
    _check_cargo_install sk skim
    _check_cargo_install starship starship
    _check_cargo_install zoxide zoxide

    # Set env variables
    if command --quiet vim
        set --export --universal EDITOR vim
    end

    if command --quiet eza
        set --export --universal EZA_COLORS "ur=0:uw=0:ux=0:ue=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:uu=0:gu=0:lc=31:lm=31;1"
    end

    if command --quiet less
        set --export --universal LESS --RAW-CONTROL-CHARS
        set --export --universal LESSCOLOR yes
        set --export --universal LESSHISTFILE /dev/null
        set --export --universal PAGER less
        set --export --universal MANPAGER less
        set --export --universal MANROFFOPT -c
    end

    if command --quiet lesspipe
        set --export --universal LESSOPEN "| /usr/bin/lesspipe %s"
        set --export --universal LESSCLOSE "/usr/bin/lesspipe %s %s"
    end

    # Source misc. config
    if command --quiet starship
        starship init fish | source
    end

    if command --quiet zoxide
        zoxide init fish | source
    end
end

if status is-login
    if test -x /usr/bin/ssh-agent && test -z $SSH_AGENT_PID && test -z $SSH_TTY
        eval (/usr/bin/ssh-agent -c)
    end

    if ! fish_is_root_user && test -z $DISPLAY
        set current_tty (tty)
        if test $current_tty = /dev/tty1
            if test -x /usr/bin/hyprland
                exec /usr/bin/hyprland
            else if test -x /usr/bin/sway
                exec /usr/bin/sway
            else if test -x /usr/bin/startx
                exec /usr/bin/startx
            end
        end
    end
end
