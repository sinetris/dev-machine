# A virtual machine for Ruby, MongoDB and Redis development.

## Introduction

This project automates the setup of a development environment for working on Ruby, MongoDB, Node.js and Redis.

### Note

This project is based on the [rails-dev-box](http://github.com/rails/rails-dev-box).

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/sinetris/dev-machine.git
    host $ cd dev-machine
    host $ git submodule init
    host $ git submodule update
    host $ vagrant up

That's it.

If the base box is not present that command fetches it first. The setup itself takes about 5 minutes in my MacBook Pro. After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-30-generic x86_64)
    ...
    vagrant@dev-machine:~$

Port 3000 in the host computer is forwarded to port 3000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via http://localhost:3000 in the host computer.

## What's In The Box

* Git

* RVM

* Ruby 2.1

* Bundler

* SQLite3

* System dependencies for nokogiri, sqlite3

* Node.js for the asset pipeline

* Memcached

* MongoDB

* Redis

* ImageMagick

* Vim

* MySQL

* PHP

* nginx

## Recommended Workflow

The recommended workflow is

* edit in the host computer and

* test within the virtual machine.

Just clone your repo in the projects directory of the development box in the host computer:

    host $ ls
    README.md   Vagrantfile puppet	projects
    host $ cd projects
    host $ git clone git@github.com:<your username>/<you repo name>.git

Vagrant mounts that very directory as `/vagrant` within the virtual machine:

    vagrant@dev-machine:~$ ls /vagrant
    puppet  projects  README.md  Vagrantfile

so we are ready to go to edit in the host, and test in the virtual machine.

This workflow is convenient because in the host computer you normally have your editor of choice fine-tuned, Git configured, and SSH keys in place.

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.
