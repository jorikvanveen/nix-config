#!/usr/bin/env nu

let services = [
    actual.service
    audiobookshelf.service
    platen-frontend.service
]

if (^id -u | str trim) != "0" {
    error make {msg: "Run this script with sudo nu."}
}

^systemctl stop ...$services
if $env.LAST_EXIT_CODE != 0 {
    error make {msg: "Some services could not be stopped. See the systemctl errors above."}
}

^systemctl show ...$services --property=Id,ActiveState,SubState --no-pager
