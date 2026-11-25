{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # OpenJDK versions
    openjdk21
    openjdk25

    # Temurin (Eclipse Adoptium) versions
    temurin-bin-21
    temurin-bin-25
  ];

  # Set temurin-bin-25 as the default Java
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.temurin-bin-25}/lib/openjdk";
  };
}
