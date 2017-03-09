#mksh-makefile - Makefile for building mksh

##Introduction

``mksh`` is a nice shell, which is based on ``pdksh`` and packing nice
features.

The only downside is ``mksh`` lacks a proper ``Makefile`` for it's build
system, so that user need to perform manual installation, which is
somewhat uncomfortable.

I wrote this my own ``Makefile`` to make it easy for me for building
``mksh``.

##Requirement

A ``make`` program. You can use GNU Make or ``make`` that comes with BSD
operating systems.

##How to use

Standard ``make`` targets are available.

``make`` will build both ``mksh`` and ``lksh`` binaries.

``make check`` will perform tests.

``make install`` will install ``mksh``, ``lksh``, and related manual
pages to ``$HOME/local``. You can modify ``PREFIX`` variable to specify
installation location.

For example, to install ``mksh`` under ``/usr/local`` directory, you can
perform it using the command below.

``# make PREFIX='/usr/local' install``

##License

This program is licensed under the MIT License.

