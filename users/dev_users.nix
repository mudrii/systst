{ config, pkgs, ... }:

{

  users = {
    mutableUsers = false;
    users.dev = {
      isNormalUser = true;
      extraGroups = [ "docker" ];
      # mkpasswd -m sha-512 password
      hashedPassword = "$6$ewXNcoQRNG$czTic9vE8CGH.eo4mabZsHVRdmTjtJF4SdDnIK0O/4STgzB5T2nD3Co.dRpVS3/uDD24YUxWrTDy2KRv7m/3N1";
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8/tE2+oIwLnCnfzPSTqiZaeW++wUPNW5fOi124eGzWfcnOQGrjuwir3sZDKMS9DLqSTDNtvJ3/EZf6z/MLN/uxUE8lA+aKaSs0yopE7csQ89Aqkvp5fvCpz3BJuZgpxtwebPZyTc7QRGQWE4lM3fix3aJhfj827bdxA+sCiq8OnNiwYSXrIag1cQigafhLy6tYtCKdWcxzJq2ebGJF2wu2LU0zArb1SAOanhEOXxz0dG1I/7yMDBDC92R287nWpL+BwxuQcDv0xh/sWnViKixKv+B9ewJnz98iQPcg3WmYWe9BYAcaqkbgMqbwfUPqOHhFXmiQWUpOjsni2O6VoiN mudrii@nixos" ];
/*
      packages = with pkgs; [
        python38Full
        (
          python3.withPackages (
            ps: with ps; [
              #poetry
              pip
              powerline
              pygments
              pygments-markdown-lexer
              xstatic-pygments
              pylint
              numpy
              pynvim
            ]
          )
        )
        ];
*/
    };
  };

}
