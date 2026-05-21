{ pkgs, inputs, ... }: {
  environment.systemPackages = [
    pkgs.ryubing
  ];
}
