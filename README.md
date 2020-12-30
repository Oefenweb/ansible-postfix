## postfix

[![Build Status](https://travis-ci.org/Oefenweb/ansible-postfix.svg?branch=master)](https://travis-ci.org/Oefenweb/ansible-postfix)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-postfix-blue.svg)](https://galaxy.ansible.com/oefenweb/postfix)

Set up a postfix server in Debian-like systems.

#### Requirements

None

#### Variables

 * `postfix_install` [default: `[postfix, mailutils, libsasl2-2, sasl2-bin, libsasl2-modules]`]: Packages to install
 * `postfix_hostname` [default: `{{ ansible_fqdn }}`]: Host name, used for `myhostname` and in `mydestination`
 * `postfix_mailname` [default: `{{ ansible_fqdn }}`]: Mail name (in `/etc/mailname`), used for `myorigin`

 * `postfix_compatibility_level` [optional]: With backwards compatibility turned on (the compatibility_level value is less than the Postfix built-in value), Postfix looks for settings that are left at their implicit default value, and logs a message when a backwards-compatible default setting is required (e.g. `2`, `Postfix >= 3.0`)

 * `postfix_default_database_type` [default: `hash`]: The default database type for use in `newaliases`, `postalias` and `postmap` commands
 * `postfix_aliases` [default: `[]`]: Aliases to ensure present in `/etc/aliases`
 * `postfix_virtual_aliases` [default: `[]`]: Virtual aliases to ensure present in `/etc/postfix/virtual`
 * `postfix_sender_canonical_maps` [default: `[]`]: Sender address rewriting in `/etc/postfix/sender_canonical_maps` ([see](http://www.postfix.org/postconf.5.html#transport_maps))
 * `postfix_sender_canonical_maps_database_type` [default: `"{{ postfix_default_database_type }}"`]: The database type for use in `postfix_sender_canonical_maps`
 * `postfix_recipient_canonical_maps` [default: `[]`]: Recipient address rewriting in `/etc/postfix/recipient_canonical_maps` ([see](http://www.postfix.org/postconf.5.html#sender_dependent_relayhost_maps))
 * `postfix_recipient_canonical_maps_database_type` [default: `"{{ postfix_default_database_type }}"`]: The database type for use in `postfix_recipient_canonical_maps`
 * `postfix_transport_maps` [default: `[]`]: Transport mapping based on recipient address `/etc/postfix/transport_maps` ([see](http://www.postfix.org/postconf.5.html#recipient_canonical_maps))
 * `postfix_transport_maps_database_type` [default: `"{{ postfix_default_database_type }}"`]: The database type for use in `postfix_transport_maps`
 * `postfix_sender_dependent_relayhost_maps` [default: `[]`]: Transport mapping based on sender address `/etc/postfix/sender_dependent_relayhost_maps` ([see](http://www.postfix.org/postconf.5.html#recipient_canonical_maps))
 * `postfix_header_checks` [default: `[]`]: Lookup tables for content inspection of primary non-MIME message headers `/etc/postfix/header_checks` ([see](http://www.postfix.org/postconf.5.html#header_checks))
 * `postfix_header_checks_database_type` [default: `regexp`]: The database type for use in `header_checks`
 * `postfix_generic` [default: `[]`]: Generic table address mapping in `/etc/postfix/generic` ([see](http://www.postfix.org/generic.5.html))

 * `postfix_mydestination` [default: `["{{ postfix_hostname }}", 'localdomain', 'localhost', 'localhost.localdomain']`]: Specifies what domains this machine will deliver locally, instead of forwarding to another machine
 * `postfix_mynetworks` [default: `['127.0.0.0/8', '[::ffff:127.0.0.0]/104', '[::1]/128']`]: The list of "trusted" remote SMTP clients that have more privileges than "strangers"
 * `postfix_inet_interfaces` [default: `all`]: Network interfaces to bind ([see](http://www.postfix.org/postconf.5.html#inet_interfaces))
 * `postfix_inet_protocols` [default: `all`]: The Internet protocols Postfix will attempt to use when making or accepting connections ([see](http://www.postfix.org/postconf.5.html#inet_protocols))

 * `postfix_relayhost` [default: `''` (no relay host)]: Hostname to relay all email to
 * `postfix_relayhost_mxlookup` [default: `false` (not using mx lookup)]: Lookup for MX record instead of A record for relayhost
 * `postfix_relayhost_port` [default: 587]: Relay port (on `postfix_relayhost`, if set)
 * `postfix_relaytls` [default: `false`]: Use TLS when sending with a relay host

 * `postfix_smtpd_client_restrictions` [optional]: List of client restrictions ([see](http://www.postfix.org/postconf.5.html#smtpd_client_restrictions))
 * `postfix_smtpd_helo_restrictions` [optional]: List of helo restrictions ([see](http://www.postfix.org/postconf.5.html#smtpd_helo_restrictions))
 * `postfix_smtpd_sender_restrictions` [optional]: List of sender restrictions ([see](http://www.postfix.org/postconf.5.html#smtpd_sender_restrictions))
 * `postfix_smtpd_recipient_restrictions` [optional]: List of recipient restrictions ([see](http://www.postfix.org/postconf.5.html#smtpd_recipient_restrictions))
 * `postfix_smtpd_relay_restrictions` [optional]: List of access restrictions for mail relay control ([see](http://www.postfix.org/postconf.5.html#smtpd_relay_restrictions))
 * `postfix_smtpd_data_restrictions` [optional]: List of data restrictions ([see](http://www.postfix.org/postconf.5.html#smtpd_data_restrictions))

 * `postfix_sasl_auth_enable` [default: `true`]: Enable SASL authentication in the SMTP client
 * `postfix_sasl_user` [default: `postmaster@{{ ansible_domain }}`]: SASL relay username
 * `postfix_sasl_password` [default: `k8+haga4@#pR`]: SASL relay password **Make sure to change!**
 * `postfix_sasl_security_options` [default: `noanonymous`]: SMTP client SASL security options
 * `postfix_sasl_tls_security_option` [default: `noanonymous`]: SMTP client SASL TLS security options
 * `postfix_sasl_mechanism_filter` [default: `''`]: SMTP client SASL authentication mechanism filter ([see](http://www.postfix.org/postconf.5.html#smtp_sasl_mechanism_filter))

 * `postfix_smtp_tls_security_level` [default: `encrypt`]: The default SMTP TLS security level for the Postfix SMTP client ([see](http://www.postfix.org/postconf.5.html#smtp_tls_security_level))
 * `postfix_smtp_tls_note_starttls_offer` [default: `true`]: Log the hostname of a remote SMTP server that offers STARTTLS, when TLS is not already enabled for that server ([see](http://www.postfix.org/postconf.5.html#smtp_tls_note_starttls_offer))
 * `postfix_smtp_tls_cafile` [optional]: A file containing CA certificates of root CAs trusted to sign either remote SMTP server certificates or intermediate CA certificates (e.g. `/etc/ssl/certs/ca-certificates.crt`)

 * `postfix_smtpd_banner` [default: `$myhostname ESMTP $mail_name (Ubuntu)`]: Greeting banner **You MUST specify $myhostname at the start of the text. This is required by the SMTP protocol.**
 * `postfix_disable_vrfy_command` [default: `false`]: Disable the `SMTP VRFY` command. This stops some techniques used to harvest email addresses
 * `postfix_message_size_limit` [default: `10240000`]: The maximal size in bytes of a message, including envelope information

 * `postfix_smtpd_tls_cert_file` [default: `/etc/ssl/certs/ssl-cert-snakeoil.pem`]: Path to certificate file
 * `postfix_smtpd_tls_key_file` [default: `/etc/ssl/certs/ssl-cert-snakeoil.key`]: Path to key file

 * `postfix_raw_options` [default: `[]`]: List of lines (to pass extra (unsupported) configuration)

## Dependencies

* `debconf`
* `debconf-utils`

#### Example(s)

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
        rewrite: postmaster@yourdomain.org
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

Provide the relay domain name and use MX records if you want to enable relaying to DNS MX records of a domain:

```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_aliases:
      - user: root
        alias: you@yourdomain.org
    postfix_relayhost: yourdomain.org
    postfix_relayhost_mxlookup: true
```

Conditional relaying:

```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_transport_maps:
      - pattern: 'root@yourdomain.org'
        result: ':'
      - pattern: '*'
        result: "smtp:{{ ansible_lo['ipv4']['address'] }}:1025"
    postfix_sender_dependent_relayhost_maps:
      - pattern: 'logcheck@yourdomain.org'
        result: 'DUNNO'
      - pattern: 'pflogsumm@yourdomain.org'
        result: 'DUNNO'
      - pattern: '*'
        result: "smtp:{{ ansible_lo['ipv4']['address'] }}:1025"
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
postfix won't send out emails anymore and you might notice error messages in the `/var/log/mail.log` file

To fix this issue, you need to visit the ([Authorizing applications & sites](http://www.google.com/accounts/IssuedAuthSubTokens?hide_authsub=1))
page under your Google Account settings. On this page enter the name of the application to be authorized (Postfix) and click on Generate button.
Set the `postfix_sasl_password` variable with the password generated by this page.

A simple example that shows how to add some raw config:

```yaml
---
- hosts: all
  roles:
    - postfix
  vars:
    postfix_raw_options:
      - |
        milter_default_action = accept
        milter_protocol = 6
        smtpd_milters = unix:opendkim/opendkim.sock unix:opendmarc/opendmarc.sock unix:spamass/spamass.sock unix:clamav/clamav-milter.ctl
        milter_connect_macros = "i j {daemon_name} v {if_name} _"
        policyd-spf_time_limit = 3600
```

#### License

MIT

#### Author Information

Mischa ter Smitten

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Oefenweb/ansible-postfix/issues)!
