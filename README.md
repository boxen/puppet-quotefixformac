# QuoteFix Puppet Module for Boxen

Install the QuoteFix plugin for Apple Mail. See [qfm][] for details.

[qfm]: https://github.com/robertklep/quotefixformac for details.

[![Build Status](https://travis-ci.org/sr/puppet-quotefixformac.png?branch=master)](https://travis-ci.org/sr/puppet-quotefixformac)

## Usage

```puppet
include quotefixformac
```

## Required Puppet Modules

* `boxen`

## Development

Set `GITHUB_API_TOKEN` in your shell with a [Github oAuth Token](https://help.github.com/articles/creating-an-oauth-token-for-command-line-use) to raise your API rate limit. You can get some work done without it, but you're less likely to encounter errors like `Unable to find module 'boxen/puppet-boxen' on https://github.com`.

Then write some code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
