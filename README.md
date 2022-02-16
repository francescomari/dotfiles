# Dotfiles

This repository contains scripts and configuration to bootstrap a fresh machine.
Most of the configuration assumes to be run on a MacOS X system.

On a fresh machine, or on an existing machine whose configuration needs to be
updated, run the setup script:

```sh
./setup.sh
```

At the end of the execution, all the necessary software and configuration should
be installed.

# Manual steps

The following tasks must be performed manually on a fresh machine:

- Log in to the JetBrains Toolbox and install the necessary IDEs.
- Log in to Visual Studio Code. This will automatically sync the preferences for
  the editor.
- Configure iterm2 to load the preferences from the `iterm2` directory in this
  repository.
