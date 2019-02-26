Ansible Playbook for JIRA
=========================

[![Build Status](https://travis-ci.org/pantarei/ansible-playbook-jira.svg?branch=master)](https://travis-ci.org/pantarei/ansible-playbook-jira)
[![GitHub tag](https://img.shields.io/github/tag/pantarei/ansible-playbook-jira.svg)](https://github.com/pantarei/ansible-playbook-jira)
[![GitHub license](https://img.shields.io/github/license/pantarei/ansible-playbook-jira.svg)](https://github.com/pantarei/ansible-playbook-jira/blob/master/LICENSE)

Ansible Playbook for Atlassian JIRA Installation.

Requirements
------------

This playbook require Ansible 2.0 or higher.

This playbook was designed for Ubuntu Server 14.04 LTS and Ubuntu Server 16.04 LTS.

Quick Start
-----------

All-in-one (AIO) builds are a great way to perform an JIRA build for

-   A development environment
-   An overview of how all of the JIRA services fit together
-   A simple lab deployment

Although AIO builds aren’t recommended for large production deployments, they’re great for smaller proof-of-concept deployments.

AIO with Customization
----------------------

There are four main steps for running a customized AIO build:

-   Install Ansible
-   Initial roles, vars and hosts bootstrap
-   Configuration *(this step is optional)*
-   Run playbooks

Start by cloning the ansible-playbook-jira repository and changing into the repository root directory:

    $ git clone https://github.com/pantarei/ansible-playbook-jira \
        /opt/ansible-playbook-jira
    $ cd /opt/ansible-playbook-jira

Next bootstrap Ansible by executing:

    $ scripts/bootstrap-ansible.sh

Now we can bootstrap Ansible's roles, vars and hosts by executing:

    $ scripts/bootstrap-aio.sh

By default the scripts deploy only JIRA and PostgreSQL. At this point you may optionally adjuct which services are deployed within your AIO build. Look at the `group_vars/all` and `inventory/aio` for more details. For example, if you'd like to upgrade your Ubuntu set the `apt_upgrade` as `full` at `group_vars/all`:

    apt_upgrade: full

Finally, run the plabooks by executing:

    $ scripts/run-playbooks.sh

Dependencies
------------

-   [hswong3i.apache2](https://github.com/pantarei/ansible-role-apache2)
-   [hswong3i.apache2\_vhosts](https://github.com/pantarei/ansible-role-apache2-vhosts)
-   [hswong3i.apt](https://github.com/pantarei/ansible-role-apt)
-   [hswong3i.hostname](https://github.com/pantarei/ansible-role-hostname)
-   [hswong3i.java](https://github.com/pantarei/ansible-role-java)
-   [hswong3i.jira](https://github.com/pantarei/ansible-role-jira)
-   [hswong3i.locales](https://github.com/pantarei/ansible-role-locales)
-   [hswong3i.mysql](https://github.com/pantarei/ansible-role-mysql)
-   [hswong3i.mysql\_connector\_java](https://github.com/pantarei/ansible-role-mysql-connector-java)
-   [hswong3i.mysql\_vhosts](https://github.com/pantarei/ansible-role-mysql-vhosts)
-   [hswong3i.ntp](https://github.com/pantarei/ansible-role-ntp)
-   [hswong3i.postgresql](https://github.com/pantarei/ansible-role-postgresql)
-   [hswong3i.postgresql\_vhosts](https://github.com/pantarei/ansible-role-postgresql-vhosts)
-   [hswong3i.tzdata](https://github.com/pantarei/ansible-role-tzdata)
-   [hswong3i.ufw](https://github.com/pantarei/ansible-role-ufw)

License
-------

-   Code released under [MIT](https://github.com/hswong3i/ansible-playbook-jira/blob/master/LICENSE)
-   Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

Author Information
------------------

-   Wong Hoi Sing Edison
    -   <a href="https://twitter.com/hswong3i" class="uri" class="uri">https://twitter.com/hswong3i</a>
    -   <a href="https://github.com/hswong3i" class="uri" class="uri">https://github.com/hswong3i</a>

