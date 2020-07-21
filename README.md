[![Build Status](http://img.shields.io/travis/cchurch/ansible-role-admin-users.svg)](https://travis-ci.org/cchurch/ansible-role-admin-users)
[![Galaxy](http://img.shields.io/badge/galaxy-cchurch.admin--users-blue.svg)](https://galaxy.ansible.com/cchurch/admin-users/)

Admin Users
===========

Manage admin users, authorized keys and sudo access.

Support for Ansible versions < 2.8 was dropped as of version 0.9.0.

Requirements
------------

The `sudo` package will be installed if not already installed. Amazon Linux also
requires the `shadow-utils` package to be installed prior to running this role.

Role Variables
--------------

The following variables may be defined to customize this role:

- `admin_users`: List of admin users to create or update; default is `[]`. Each
  item in this list should be a hash with the following keys:

   - `username`: Username of the admin user (required).
   - `fullname`: Full name for the admin user (optional).
   - `shell`: Default shell for this user; `admin_users_default_shell` will be
     used if this key is omitted.
   - `pubkey`: The public key to associate with the given user. This value can
     be a string containing the content of the user's public key, a string
     containing a URL to a list of keys (e.g https://github.com/username.keys),
     or a list of multiple strings containing either public key content or URLs.
     *Support for lists of keys was added in 0.7.0.*
   - `pubkey_options`: Additional options to pass to the `authorized_key`
     module (optional).
   - `exclusive`: Boolean indicating whether to remove all other public keys
     (optional).

- `admin_user_groups`: : Boolean indicating whether to create/remove; default is
  `true`.
- `admin_users_sudo_nopasswd`: Boolean indicating whether to enable sudo with
  the `NOPASSWD` option for admin users; default is `true`.
- `admin_users_default_shell`: Default shell for admin users; default is
  `"/bin/bash"`.
- `admin_users_to_remove`: List of usernames to remove from the remote system;
  default is `[]`. If `admin_user_groups` is `true`, groups with these usernames
  will also be removed.

Dependencies
------------

None.

Example Playbook
----------------

The following playbook updates admin users on dev and prod servers with
different options:

    - hosts: dev-servers
      vars:
        dev_admin_users:
          - username: joe
            fullname: "Joe Dev"
            pubkey:
              - "ssh-rsa ..."
              - "ssh-dsa ..."
          - username: jim
            fullname: "Jim Dev"
            shell: "/bin/sh"
            pubkey: "https://github.com/jim.keys"
            exclusive: true
      roles:
        - role: cchurch.admin-users
          admin_users: dev_admin_users
    - hosts: prod-servers
      vars:
        prod_admin_users:
          - username: jon
            fullname: "Jon Admin"
            pubkey: "ssh-rsa ..."
      roles:
        - role: cchurch.admin-users
          admin_users: prod_admin_users
          admin_users_sudo_nopasswd: false

License
-------

BSD

Author Information
------------------

Chris Church ([cchurch](https://github.com/cchurch))
