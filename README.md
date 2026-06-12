# dotfiles

This is my _dotfiles_ repository for repeatable/predictable set up of different environments.

I've developed this over a number of years after working with multiple development servers,
and a long list of various laptops.

It does not presume availability of any particular tools, so the majority is `bash` scripts
as this is ubiquitous in the environments I mostly work with: macOS laptop, Linux servers,
legacy Big Iron servers, Linux VMs and WSL on Windows.

## Quick Start (TL;DR)

1. Clone the repo to `~/.dotfiles`
2. Install to that environment `~/.dotfiles/install.sh`.
3. Create new login to the environment - it auto-configures as you login.

## How This Works

This system has two lifecycles:

### 1. New Environment Setup

When I get a new laptop, create a new VM or get a new account on some server, I download
this repository:

```bash
cd ~
git clone https://github.com/jbrwilkinson/dotfiles .dotfiles
```

> Note that we're specifically installing into the user home folder as a hidden
> folder `.dotfiles`. More on this later.

To install the setup into the new environment:

```bash
cd .dotfiles
./install.sh
```

This will _soft link_ the files that are in the `.dotfiles` repository into the home
folder so that, if they change, we can capture the changes and check them back in to
the repository.

Depending on the environment, a number of tools might also be installed, for example:

- text editor `vim`
- terminal multiplexer `tmux`
- command prompt `starship`

This only happens for environments where we have admin/sudo access.

### 2. Shell/Console login to Environment

After installation, every shell or console login to a system where the environment is
installed will kick off some quick configuration of that command-line session in terms
of:

1. Command *aliases* I find helpful, like `ll` short for `ls -lAh` and adding `-p` to `mkdir`
   as I often forget that.
2. Environment variables that matter to the tools that I use such as `GH_HOST` which tells the
   `gh` tool which server I should use.

The configuration of the session is controlled by a number of script files which are executed
based on the presence of various environment variables or files.
