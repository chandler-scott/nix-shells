{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nmap           # Network scanning
    pkgs.metasploit     # Exploitation framework
    pkgs.john           # Password cracking
    pkgs.hashcat        # Advanced password cracking
    pkgs.sqlmap         # SQL injection automation
    pkgs.aircrack-ng    # Wireless security tools
    pkgs.socat          # Multipurpose relay tool
    pkgs.netcat         # Network utility for reading/writing across networks
  ];

  shellHook = ''
    echo "Environment ready for Red Teaming."
    echo "Available tools: nmap, metasploit, john, hashcat, hydra, sqlmap, aircrack-ng, socat, netcat, wireshark"
  '';
}

