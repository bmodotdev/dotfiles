#########
# Setup #
#########
source ~/perl5/perlbrew/etc/bashrc

###########
# Aliases #
###########
set_alias p 'perl -Mstrict -MData::Dumper'
set_alias pb perlbrew
set_alias pc perlcritic
set_alias pd perldoc
set_alias pt perltidy

#############
# Functions #
#############

function install_perlbrew () {
    local bin="${GIT_DIR}App-perlbrew/perlbrew"
    if [ ! -x "$bin" ]; then
        >&2 printf 'perlbrew missing or not executable: “%s”\n' "$bin"
        return
    fi

    printf 'Perofmring self install...\n'
    "$bin" self-install

    printf 'Performing install-patchperl...\n'
    "$bin" -f -q install-patchperl
}
