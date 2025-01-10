{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "esp32-dev";

  buildInputs = [
    pkgs.python3
    pkgs.cmake
    pkgs.ninja
    pkgs.gcc
    pkgs.git
    pkgs.wget
    pkgs.unzip
  ];

  shellHook = ''
    # Setup ESP-IDF environment
    export IDF_PATH=/usr/local/esp-idf

    if [ ! -d "$IDF_PATH" ]; then
      echo "ESP-IDF not found, cloning..."
      sudo git clone --recursive https://github.com/espressif/esp-idf.git $IDF_PATH
      $HOME/esp-idf/install.sh
    fi

    # Source the ESP-IDF environment variables
    . $IDF_PATH/export.sh

    # Set ESP32 aliases
    alias build="idf.py build"
    alias monitor="idf.py monitor"
  
    flash() {
      if [[ -z $1 && -z $PORT ]]; then
        read -p "Would you like to change the default port `/dev/ttyUSB0`? (y/n): " choice
        if [[ $choice =~ ^[Yy]$ ]]; then
          set_port
        else
          PORT="/dev/ttyUSB0"
          return 1 
        fi
      fi

      if [[ ! -z $1 ]]; then
        PORT=$1
      fi

      idf.py --port $PORT flash
    }

    set_port() {
      local port
      if [[ -z $1 ]]; then
        read -p "What port for your device? " port
      else
        port=$1 
      fi
      
      export PORT=$port
    }

    deploy() {
      build && flash && monitor
    }

    export -f set_port
    export -f flash
    export -f deploy 
    
    # Build directories
    export COMPONENTS_DIR="$HOME/src/esp32/components"
    export LIB_DIR="$HOME/src/esp32/lib"

    # Other useful directories
    export ESP_HOME="$HOME/src/esp32"

    cd $ESP32_HOME

    # Print a nice message
    echo "ESP32 Development Environment Ready."
  '';
}

