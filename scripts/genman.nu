#!/usr/bin/env nu

# | gen | date | current |
def get_gens [] {
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system/ | from ssv -n | rename gen date current | into value
}

def "main" [] {
    let gens = get_gens;
    $gens
}

def "main beforegen" [selected_gen: int] {
    let gens = get_gens | where gen < $selected_gen;
    let profiles = echo $gens | get gen;
    delete_profiles $profiles;
}

def "main older" [dur: duration] {
    let gens = get_gens | where date < (date now | $in - $dur)
    let profiles = echo $gens | get gen;
    delete_profiles $profiles;
}

def delete_profiles [profiles: list<int>] {
    exec sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system ...$profiles
}
