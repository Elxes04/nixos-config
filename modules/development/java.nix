{ config, pkgs, ... }:

{
  # Install Java for Minecraft and other applications
  programs.java = {
    enable = true;
    package = pkgs.jdk21; # Latest LTS version (default)
  };

  environment.systemPackages = with pkgs; [
    # Java Development Kit (JDK) - includes javac, jar, etc.
    jdk21          # Java 21 LTS (recommended for modern Minecraft)
    jdk17          # Java 17 LTS (for older Minecraft versions 1.18+)
    jdk8           # Java 8 (for legacy Minecraft versions)
    
    # Create wrapper scripts for easy version selection
    (pkgs.writeShellScriptBin "java8" ''
      exec ${pkgs.jdk8}/bin/java "$@"
    '')
    (pkgs.writeShellScriptBin "java17" ''
      exec ${pkgs.jdk17}/bin/java "$@"
    '')
    (pkgs.writeShellScriptBin "java21" ''
      exec ${pkgs.jdk21}/bin/java "$@"
    '')
    
    # Useful Java tools
    # maven        # Uncomment if you need Maven
    # gradle       # Uncomment if you need Gradle
  ];

  # Set JAVA_HOME environment variable (points to default Java)
  environment.variables = {
    JAVA_HOME = "${pkgs.jdk21}";
  };
  
  # Note: To use a specific Java version, use these commands:
  # - java8 -jar file.jar    (for Java 8)
  # - java17 -jar file.jar   (for Java 17)  
  # - java21 -jar file.jar   (for Java 21)
  # - java -jar file.jar     (uses default: Java 21)
}
