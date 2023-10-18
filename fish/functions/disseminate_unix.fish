function disseminate_unix
  if is_raspberry
    echo "Running on Raspberry Pi, skipping Homebrew installation."
  else if not type -q brew 
    /bin/bash -c "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  end
end
