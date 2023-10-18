function disseminate_unix
  if is_raspberry
  then
    echo "Running on Raspberry Pi, skipping Homebrew installation."
  else
    if ! type -q brew 
    then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  fi
end
