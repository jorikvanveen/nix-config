{
  services.gitlab-runner = {
    enable = true;
    services = {
      #docker-images = {
      #  # File should contain at least these two variables:
      #  # `CI_SERVER_URL`
      #  # `CI_SERVER_TOKEN`
      #  authenticationTokenConfigFile = "/run/secrets/gitlab-runner-docker-images-token-env";

      #  dockerImage = "docker:stable";
      #  dockerVolumes = [
      #    "/var/run/docker.sock:/var/run/docker.sock"
      #  ];
      #  tagList = [ "docker-images" ];
      #};
      default = {
        # File should contain at least these two variables:
        # `CI_SERVER_URL`
        # `CI_SERVER_TOKEN`
        authenticationTokenConfigFile = "/run/secrets/gitlab-runner-docker-images-token-env";
        dockerImage = "debian:stable";
      };
    };
  };
}
