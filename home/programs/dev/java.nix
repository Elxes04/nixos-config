{ pkgs, ... }:

{
  # Default Java package in user PATH
  home.packages = [
    pkgs.temurin-bin-25
  ];

  # Make all required Java runtimes available in ~/.local/share/java / ~/.jdks for Prism Launcher and IDEs
  # without causing PATH collisions in buildEnv
  home.file = {
    ".jdks/openjdk-21".source = "${pkgs.openjdk21}";
    ".jdks/openjdk-25".source = "${pkgs.openjdk25}";
    ".jdks/temurin-bin-21".source = "${pkgs.temurin-bin-21}";
    ".jdks/temurin-bin-25".source = "${pkgs.temurin-bin-25}";
  };

  # Set temurin-bin-25 as the default Java
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.temurin-bin-25}/lib/openjdk";
  };
}
