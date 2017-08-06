# elixir-experiments

## Elixir Setup on Cloud9 (Ubuntu container)
```
# For some reason, installing Elixir tries to remove this file
# and if it doesn't exist, Elixir won't install. So, we create it.
sudo touch /etc/init.d/couchdb

# Standard Ubuntu Elixir installation instructions
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -O /tmp/erlang-solutions_1.0_all.deb
sudo dpkg -i /tmp/erlang-solutions_1.0_all.deb
rm /tmp/erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install elixir

# Run an interactive shell
iex
```

These steps are from https://community.c9.io/t/writing-an-elixir-app/4881

## Exercism setup on Cloud9
Find latest releases at https://github.com/exercism/cli/releases/

```
$ wget https://github.com/exercism/cli/releases/download/v2.4.1/exercism-linux-64bit.tgz
$ tar xzf exercism-linux-64bit.tgz
$ mkdir bin
$ mv exercism bin
$ export PATH=~/bin/workspace:$PATH
```

Get your exercism API key at http://exercism.io/account/key

```
exercism configure --key=abcd1234 --dir=~/workspace/exercism
$ exercism fetch elixir

```

## Notes
I'm adding various notes I take to [[NOTES.md]].

Have fun!