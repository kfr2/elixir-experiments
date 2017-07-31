# elixir-experiments

## setup on Cloud9 (Ubuntu container)
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


```

These steps are from https://community.c9.io/t/writing-an-elixir-app/4881