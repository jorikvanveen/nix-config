{ pkgs, ... }: {
  virtualisation.oci-containers.containers.hoarder = {
    image = "hoarder"; 

  };
}
