# Homelab WireGuard access

The homelab uses `wg0`, address `10.66.66.1/24`, and UDP port `51820`.
Only these Caddy hosts stay public:

- `j.jorik-dev.com` (Jellyfin)
- `vw.jorik-dev.com` (Vaultwarden)
- `bitwarden.tobeqz-on.top` (Vaultwarden)
- `atuin.jorik-dev.com` (Atuin)
- `tutorials.jorik-dev.com` (Tutorials)

All host definitions live in `nixos-installs/modules/services/caddy.nix`, under
public and private sections. Each private host contains its own `@wireguard`
matcher and `handle` blocks. Websites, webhooks, Matrix, ntfy, and application
APIs are currently in the private section.
These matchers allow the VPN subnet `10.66.66.0/24` and local connections from
IPv4 loopback `127.0.0.0/8` or IPv6 loopback `::1`.
Caddy still handles public certificate challenges and HTTP-to-HTTPS redirects.

To make a host private, copy the matcher and both `handle` blocks from another
private host, putting its existing directives inside `handle @wireguard`.
To make it public, remove that wrapper and keep its service directives.
Also add or remove the host's explicit `host-record` and `local` DNS entries in
`nixos-installs/modules/wireguard.nix`. New hosts need an explicit access rule;
there is no automatic wrapping or host discovery.

During bootstrap, public TCP ports are 22 (SSH), 80, 443, and 54345 (BitTorrent
peers). Allowed UDP ports are 443 (HTTP/3), 5353 (mDNS discovery), 51820
(WireGuard), and 54345 (BitTorrent peers). mDNS remains available for `.local`
name discovery on the LAN. SSH temporarily stays reachable over the LAN/public address
so you can complete setup remotely. Close non-VPN SSH using the steps below
after confirming the VPN works. Syncthing and Minecraft require WireGuard.
Service backend ports are blocked externally; use Caddy for web UIs. The qBittorrent UI stays
on loopback behind its VPN/loopback-restricted Caddy host; torrent peer connections stay public.
Syncthing discovery and relays are disabled on the server; configure other
devices with `tcp://10.66.66.1:22000` as the homelab's address and connect their
VPN first. Outbound downloads still use the server's normal internet connection.

## Before activation

1. Make sure `10.66.66.0/24` does not overlap a network used by your clients.
2. Forward UDP port 51820 on your router to the homelab. Use a DNS name that
   resolves directly to your public IP as the client endpoint; an HTTP CDN or
   reverse proxy cannot carry this WireGuard UDP connection. If your connection
   is behind CGNAT, you need a reachable endpoint such as a VPS or an ISP public
   address before remote clients can connect.
3. Create a tunnel on each client using its WireGuard app, keeping its private
   key on that device. Add its **public** key to
   `nixos-installs/modules/wireguard-peers.nix`, using a unique `/32` address
   from `10.66.66.2` through `10.66.66.254`.
4. Keep your existing SSH session open and activate from it. The bootstrap
   configuration retains port 22 in the global `allowedTCPPorts` list, so you
   can still open new SSH connections over the LAN/public address while
   setting up the VPN. Private web services require the configured tunnel.
   An empty peer list is safe for this initial rebuild while port 22 is open;
   add your client public key and rebuild before testing the VPN.

```bash
sudo nixos-rebuild switch --flake path:/home/main/nix-config#nixos-homelab
sudo wg show wg0 public-key
```

The first activation generates `/var/lib/wireguard/private-key` with mode 0600.
The key persists across rebuilds. Back it up securely; it is never put in Git
or the Nix store. Use the public key printed above in the client configuration.

## Client configuration

Example for the device assigned `10.66.66.2`:

```ini
[Interface]
PrivateKey = CLIENT_PRIVATE_KEY
Address = 10.66.66.2/32
DNS = 10.66.66.1

[Peer]
PublicKey = SERVER_PUBLIC_KEY
Endpoint = YOUR_PUBLIC_IP_OR_DNS_NAME:51820
AllowedIPs = 10.66.66.0/24
PersistentKeepalive = 25
```

Import this locally on the client; do not commit a completed configuration with
its private key. Each client needs its own key and address. The client routes
only the VPN subnet through WireGuard. Its DNS queries go to the server's
resolver, which answers private hostnames with `10.66.66.1` and forwards other
queries upstream. Configure the client OS/browser to use this resolver rather
than a separate secure-DNS provider for these names. Public DNS records do not
need to change. Private AAAA queries receive no public IPv6 address.

Keep using normal HTTPS names such as `https://s.jorik-dev.com` while connected.
Connecting directly to the public address of a private host returns HTTP 403,
even if the WireGuard tunnel is on. The private DNS answer is what directs the
request through the tunnel. Public Jellyfin, Vaultwarden, Atuin, and Tutorials
names keep their public DNS answers and work without WireGuard.

## Close non-VPN SSH after setup

Keep the original SSH session open throughout these steps.

1. Connect the client to WireGuard. In a **new terminal on the client**, open a
   fresh SSH session directly to the server's VPN address:

   ```bash
   ssh main@10.66.66.1
   ```

2. From that VPN SSH session, edit `nixos-installs/modules/wireguard.nix`.
   Remove the bootstrap comment and change the global TCP list to:

   ```nix
   allowedTCPPorts = lib.mkForce [ 80 443 ];
   ```

   Keep port 22 in `interfaces.wg0.allowedTCPPorts`.

3. Apply the change from the VPN SSH session:

   ```bash
   sudo nixos-rebuild switch --flake path:/home/main/nix-config#nixos-homelab
   ```

4. Open another **fresh** `ssh main@10.66.66.1` session to verify access after
   the rebuild. Existing sessions can survive firewall changes, so keeping a
   session connected does not by itself verify that new connections work.
   Confirm new SSH connections to the LAN/public address are now blocked.
   Once these checks pass, you can close the original SSH session.

If the initial VPN SSH connection fails, leave public port 22 in place and fix
the client configuration, peer public key, or UDP forwarding first. There is
no need to visit the server room for this sequence.

## Verify after activation

- On the server, `sudo wg show wg0` should show a recent client handshake.
- On a connected client, `nslookup s.jorik-dev.com 10.66.66.1` should return
  `10.66.66.1`; the normal HTTPS URL should load.
- From outside the VPN, private hostnames should return 403, while Jellyfin,
  Atuin, Tutorials, and both Vaultwarden domains should work normally.
- Check that public IPv4 and IPv6 cannot reach backend ports. After completing
  the SSH lockdown above, also verify that non-VPN SSH is blocked. Keep the
  torrent peer port 54345 reachable and remove obsolete router forwards and
  automatic UPnP mappings for private services.

See the [WireGuard quick start](https://www.wireguard.com/quickstart/),
[Caddy request matchers](https://caddyserver.com/docs/caddyfile/matchers#remote_ip),
and [Docker port publishing](https://docs.docker.com/engine/network/port-publishing/).
