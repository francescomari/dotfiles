# Dotfiles

This repository contains scripts and configuration to bootstrap a fresh machine.
Most of the configuration assumes to be run on a MacOS X system.

On a fresh machine, or on an existing machine whose configuration needs to be
updated, run the setup script:

```sh
./setup.sh [-v] [home|work]
```

By default, the script outputs concise messages outlining the performed actions.
Use the `-v` flag to instruct the script to print the output of every command.

At the end of the execution, all the necessary software and configuration should
be installed.
