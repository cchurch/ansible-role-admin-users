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

    admin_users_sudo_nopasswd: yes

    admin_users_to_remove:
      - bob
      - fred

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
           admin_users_sudo_nopasswd: no

License
-------

BSD

Author Information
------------------

Chris Church
chris@ninemoreminutes.com
