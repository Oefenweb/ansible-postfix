## postfix

[![Build Status](https://travis-ci.org/Oefenweb/ansible-postfix.svg?branch=master)](https://travis-ci.org/Oefenweb/ansible-postfix) [![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-postfix-blue.svg)](https://galaxy.ansible.com/tersmitten/postfix)

Set up a postfix server in Debian-like or EL systems.

#### Requirements

None

#### Variables

 * `postfix_install` [default: `[postfix, mailutils, libsasl2-2, sasl2-bin, libsasl2-modules]`]: Packages to install
 * `postfix_hostname` [default: `{{ ansible_fqdn }}`]: Host name, used for `myhostname` and in `mydestination`
 * `postfix_mailname` [default: `{{ ansible_fqdn }}`]: Mail name (in `/etc/mailname`), used for `myorigin`
 * `postfix_aliases` [default: `[]`]: Aliases to ensure present in `/etc/aliases`
 * `postfix_virtual_aliases` [default: `[]`]: Virtual aliases to ensure present in `/etc/postfix/virtual`
 * `postfix_sender_canonical_maps` [default: `[]`]: Sender address rewriting in `/etc/postfix/sender_canonical_maps` ([see](http://www.postfix.org/postconf.5.html#sender_canonical_maps))
 * `postfix_generic:` [default: `[]`]: Generic table address mapping in `/etc/postfix/generic`
   ([see](http://www.postfix.org/generic.5.html))
 * `postfix_mydestination` [default: `["{{ postfix_hostname }}", 'localdomain', 'localhost', 'localhost.localdomain']`]: Specifies what domains this machine will deliver locally, instead of forwarding to another machine
 * `postfix_mynetworks` [default: `['127.0.0.0/8', '[::ffff:127.0.0.0]/104', '[::1]/128']`]: The list of "trusted" remote SMTP clients that have more privileges than "strangers"
 * `postfix_inet_interfaces` [default: `all`]: Network interfaces to bind ([see](http://www.postfix.org/postconf.5.html#inet_interfaces))
 * `postfix_inet_protocols` [default: `all`]: The Internet protocols Postfix will attempt to use when making or accepting connections ([see](http://www.postfix.org/postconf.5.html#inet_protocols))
 * `postfix_sasl_auth_enable` [default: `true`]: Enable SASL authentication in the SMTP client
 * `postfix_relayhost` [default: `false` (no relay host)]: Hostname to relay all email to
 * `postfix_relayhost_port` [default: 587]: Relay port (on `postfix_relayhost`, if set)
 * `postfix_sasl_security_options` [default: `noanonymous`]: SMTP client SASL security options
 * `postfix_relaytls` [default: `false`]: Use TLS when sending with a relay host
 * `postfix_smtp_tls_cafile` [optional]: A file containing CA certificates of root CAs trusted to sign either remote SMTP server certificates or intermediate CA certificates (e.g. `/etc/ssl/certs/ca-certificates.crt`)
 * `postfix_sasl_user` [default: `postmaster@{{ ansible_domain }}`]: SASL relay username
 * `postfix_sasl_password` [default: `k8+haga4@#pR`]: SASL relay password **Make sure to change!**
 * `postfix_smtpd_banner` [default: `$myhostname ESMTP $mail_name (Ubuntu)`]: Greeting banner **You MUST specify $myhostname at the start of the text. This is required by the SMTP protocol.**
 * `postfix_disable_vrfy_command` [default: `false`]: Disable the `SMTP VRFY` command. This stops some techniques used to harvest email addresses

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
      - user: root
        alias: you@yourdomain.org
```

A simple example with virtual aliases for mail forwarding that doesn't use SASL relaying:
```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_mydestination:
      - "{{ postfix_hostname }}"
      - '$mydomain'
      - localdomain
      - localhost
      - localhost.localdomain
    postfix_virtual_aliases:
      - virtual: webmaster@yourdomain.com
        alias: personal_email@gmail.com
      - virtual: billandbob@yourdomain.com
        alias: bill@gmail.com, bob@gmail.com
```

A simple example that rewrites the sender address:
```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_sender_canonical_maps:
      - sender: root
        rewrite: postmaster@example.com
```

Provide the relay host name if you want to enable relaying:
```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_aliases:
      - user: root
        alias: you@yourdomain.org
    postfix_relayhost: mail.yourdomain.org
```

For AWS SES support:
```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_aliases:
      - user: root
        alias: sesverified@yourdomain.org
    postfix_relayhost: email-smtp.us-east-1.amazonaws.com
    postfix_relaytls: true
    # AWS IAM SES credentials (not access key):
    postfix_sasl_user: AKIXXXXXXXXXXXXXXXXX
    postfix_sasl_password: ASDFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

For MailHog support:
```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_aliases:
      - user: root
        alias: you@yourdomain.org
    postfix_relayhost: "{{ ansible_lo['ipv4']['address'] }}"
    postfix_relayhost_port: 1025
    postfix_sasl_auth_enable: false
```

For Gmail support:
```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_aliases:
      - user: root
        alias: you@yourdomain.org
    postfix_relayhost: smtp.gmail.com
    postfix_relaytls: true
    postfix_smtp_tls_cafile: /etc/ssl/certs/ca-certificates.crt
    postfix_sasl_user: 'foo'
    postfix_sasl_password: 'bar'
```

If you configure your Google account for extra security to use the 2-step verification, then
postfix won't send out emails anymore and you might notice error messages in the /var/log/mail.log file

To fix this issue, you need to visit the ([Authorizing applications & sites](http://www.google.com/accounts/IssuedAuthSubTokens?hide_authsub=1)) page under your Google Account settings. On this page page enter the name of the application to be authorized (Postfix) and click on Generate  button. Set the ```postfix_sasl_password``` variable with the password generated by this page.

#### License

MIT

#### Author Information

Mischa ter Smitten

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Oefenweb/ansible-postfix/issues)!
