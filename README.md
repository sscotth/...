# df

Building my dotfiles repo mostly from scratch.

## Download

```sh
rm -rf ~/.dotfiles
git clone https://github.com/sscotth/df ~/.dotfiles
```

or

```sh
rm -rf ~/.dotfiles
mkdir -p ~/.dotfiles
curl -sL https://github.com/sscotth/df/archive/master.zip | tar xvz --strip 1 -C ~/.dotfiles
```

or

```sh
rm -rf /tmp/df
rm -rf ~/.dotfiles
mkdir -p /tmp/df
curl -sL https://github.com/sscotth/df/archive/master.zip -o /tmp/df/df.zip
unzip /tmp/df/df.zip -d /tmp/df
mv /tmp/df/df-master ~/.dotfiles
rm -rf /tmp/df
```

## Install

```sh
cd ~/.dotfiles
./install.sh
```

## Resources

[Popular "dotfiles" Repositories](https://github.com/search?o=desc&q=dotfiles&s=stars&type=Repositories&utf8=%E2%9C%93)
[Additional "awesome" resources](https://github.com/webpro/awesome-dotfiles)
