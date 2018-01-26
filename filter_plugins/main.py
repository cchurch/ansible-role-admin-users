from jinja2.filters import do_unique


class FilterModule(object):

    def filters(self):
        return {
            # The Ansible unique set filter replaces the default Jinja2 unique
            # filter, so make it available as admin_users_unique instead.
            'admin_users_unique': do_unique,
        }
