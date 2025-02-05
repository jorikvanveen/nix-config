{ unstable, pkgs-stable, ... }: {
  services.open-webui = {
    enable = true;
    port = 8090;
    package = unstable.open-webui;
  };

  systemd.services.litellm-claude = let
    py-env = (unstable.python3.withPackages
      (ppkgs: with ppkgs; [ litellm ] ++ litellm.optional-dependencies.proxy));
  in {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    description = "OpenAI-compatible proxy for claude, used by open-webui";
    script = ''
      export ANTHROPIC_API_KEY=$(cat $CREDENTIALS_DIRECTORY/anthropic-key);
      ${py-env}/bin/litellm --model anthropic/claude-3-5-sonnet-20241022 --port 4001
    '';
    serviceConfig = {
      LoadCredential = "anthropic-key:/run/secrets/anthropic-key";
      Type = "simple";
    };
  };
}
