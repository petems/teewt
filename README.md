# Teewt
[![Build Status](https://travis-ci.org/petems/teewt.svg?branch=master)](https://travis-ci.org/petems/teewt)
[![Coverage Status](https://coveralls.io/repos/github/petems/teewt/badge.svg?branch=master)](https://coveralls.io/github/petems/teewt?branch=master)

A command line tool for deleting old tweets and favs.

## Installation

    gem install teewt

## Configuration

Run the configuration utility, `teewt authorize`. You can grab your keys
[here](https://cloud.digitalocean.com/api_access).

    $ teewt authorize
    Authentication with Twitter was successful!

This will create a .teewt file in your home folder (eg. ~/.teewt).

Teewt will look for a .teewt config file first in the current directory you're running it in, then will look for one in the home directory.

An example of a `.teewt` file:

```yaml
---
authentication:
  consumer_key: UZwKrx4t8asdfvaufcjiVF2IS
  consumer_secret: 0Xhp81SyzmBDojtei3ngn5u3aapzjjdfTVo7WgUG06g7W0L
  access_token: 881938362285912066-KR2380uSasdvk2n1QJfdIu5TuP
  access_token_secret: WxPjZA6xfemck3mm0fam4Qs5azl6mOsVM
```

## Help

If you're curious about command flags for a specific command, you can
ask teewt about it.

    $ teewt help verify

For a complete overview of all of the available commands, run:

    $ teewt help

Depending on your local configuration, you may need to install a CA bundle (OS X only) using [homebrew](http://brew.sh/) to communicate with Twitter through SSL/TLS:

    $ brew install curl-ca-bundle

After installation, source the bundle path in your `.bash_profile`/`.bashrc`:

    export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

## Reporting Bugs

Yes, please!

You can create a new issue [here](https://github.com/petems/teewt/issues/new)

## Contributing

See the [contributing guide](CONTRIBUTING.md).
