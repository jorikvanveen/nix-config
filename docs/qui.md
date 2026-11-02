# Qui

Qui runs as a native NixOS service on `127.0.0.1:7476`, with persistent
state in `/var/lib/qui`. It runs as `main:users` to access qBittorrent's
files. The service binds `/mnt/media/data/qbittorrent/downloads` to
`/downloads` in its own mount namespace, matching qBittorrent's container.

Before activation, generate a secret with `openssl rand -hex 32`, then run
`sops secrets.yaml` and add it as the top-level `qui-session-secret` entry.
SOPS supplies the secret through systemd credentials and restarts qui when
it changes.

Add a proxied Cloudflare DNS record for `qui.jorik-dev.com` pointing at the
homelab so Caddy can obtain its certificate. WireGuard DNS maps this hostname
to `10.66.66.1`, and Caddy restricts access to WireGuard and loopback clients.

Stage the new module before building the Git flake, then activate on the homelab:

```sh
sudo nixos-rebuild switch --flake .#nixos-homelab
```

Connect to WireGuard and open `https://qui.jorik-dev.com`. Create your account
and add qBittorrent at `http://127.0.0.1:8081` with its existing credentials.
Enable Local Filesystem Access in qui's instance settings when configuring
filesystem features. Configure indexers and cross-seeding in qui's UI as needed.

If the previous Docker configuration was already deployed, stop `docker-qui`
and back up `/mnt/media/data/qui/appdata` before switching. To preserve its
state, copy that directory's contents into `/var/lib/qui` while both services
are stopped, and set ownership to `main:users`. NixOS manages `config.toml`,
so transfer any required non-secret settings into `services.qui.settings`.

The old cross-seed container is disabled by removing its module import. Its
configuration in `/home/main/.config/cross-seed` and downloads are preserved.

Check startup with `systemctl status qui` and `journalctl -u qui`.

Reference: [pinned NixOS module](https://github.com/NixOS/nixpkgs/blob/6510408d147d8c5e6d76043e899e9251756f6a75/nixos/modules/services/torrent/qui.nix).
