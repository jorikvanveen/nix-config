[
  # Add one entry per device. Only PUBLIC keys belong in this file.
  # Each device needs its own address and key; reserve 10.66.66.1 for the server.
  {
    name = "pc";
    publicKey = "gL4Z/MVeBf0g6oDLChXM89UC9D1s1ZwcDGtx1FZGzTQ=";
    allowedIPs = [ "10.66.66.2/32" ];
  }
  {
    name = "phone";
    publicKey = "gYgJfp1fiGs7A3wLYZHI9dH89FsJ80ks9YR0oHvFU3w=";
    allowedIPs = [ "10.66.66.3/32"];
  }
]
