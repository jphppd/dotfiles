function _check_cargo_install
    if command --quiet $argv[1]
        return 0
    end

    while true
        read -l -P "Fish: do you want to install $argv[2..-1] via cargo? [y/N] " confirm
        switch $confirm
            case Y y
                cargo install $argv[2..-1]
                return 0
            case '' N n
                return 1
        end
    end
end
