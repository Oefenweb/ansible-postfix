## postfix

[![Build Status](https://travis-ci.org/Oefenweb/ansible-postfix.svg?branch=master)](https://travis-ci.org/Oefenweb/ansible-postfix) [![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-postfix-blue.svg)](https://galaxy.ansible.com/list#/roles/1400)

Set up a postfix server in Debian-like systems.

#### Requirements

None

#### Variables

 * `postfix_install` [default: `[postfix, mailutils, libsasl2-2, sasl2-bin, libsasl2-modules`]]: Packages to install
 * `postfix_hostname` [default: `{{ ansible_fqdn }}`]: Host name, used for `myhostname` and in `mydestination`
 * `postfix_mailname` [default: `{{ ansible_fqdn }}`]: Mail name (in `/etc/mailname`), used for `myorigin`
 * `postfix_aliases` [default: `[]`]: Aliases to ensure present in `/etc/aliases`
 * `postfix_relayhost` [default: `false` (no relay host)]: Hostname to relay all email to
 * `postfix_relayport` [default: 587]: Relay port (on postfix_relayhost, if set)
 * `postfix_sasl_user` [default: `postmaster@{{ ansible_domain }}`]: SASL relay username
 * `postfix_sasl_password` [default: `k8+haga4@#pR`]: SASL relay password
 
## Dependencies

* `debconf`
* `debconf-utils`

#### Example

A simple example that doesn't use SASL relaying:
```yaml
---
- hosts: all
  roles:
  - postfix
  vars:
    postfix_aliases:
    - { user: root, alias: you@yourdomain.org }
```

Provide the relay host name if you want to enable relaying:
```yaml
---
- hosts: all
  roles:
  - postfix
  vars:
    postfix_aliases:
    - { user: root, alias: you@yourdomain.org }
    postfix_relayhost: mail.yourdomain.org
```

#### License

MIT

#### Author Information

Mischa ter Smitten

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Oefenweb/ansible-postfix/issues)!
