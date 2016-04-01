Admin Users
===========

Manage admin users, authorized keys and sudo access.

Requirements
------------

None.

Role Variables
--------------

Define the following variables in your inventory or playbook to create, update
and remove admin users:

    admin_users:
      - username: joe
        fullname: "Joe User"
        pubkey: "ssh-rsa ..."
      - username: jim
        fullname: "Jim User"
        pubkey: "ssh-rsa ..."
        shell: "/bin/sh"

    admin_users_sudo_nopasswd: true

    admin_users_default_shell: "/bin/bash"

    admin_users_to_remove:
      - bob
      - fred

You can specify a default shell for all users, or specify a different shell for
each user.

Dependencies
------------

None.

Example Playbook
----------------

The following playbook updates admin users on dev and prod servers with
different options:

    - hosts: dev-servers
      roles:
        - role: cchurch.admin-users
          admin_users: dev_admin_users
     - hosts: prod-servers
       roles:
         - role: cchurch.admin-users
           admin_users: prod_admin_users
           admin_users_sudo_nopasswd: false

License
-------

BSD

Author Information
------------------

Chris Church
chris@ninemoreminutes.com
