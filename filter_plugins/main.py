try:
    from jinja2.filters import do_unique
except ImportError:
    # Jinja2 < 2.10 doesn't provide the "unique" filter, so copy that code and
    # dependent functions here to make this role work regardless of Jinja2
    # version.
    from jinja2.filters import environmentfilter
    from jinja2._compat import string_types

    def make_attrgetter(environment, attribute, postprocess=None):
        if attribute is None:
            attribute = []
        elif isinstance(attribute, string_types):
            attribute = [int(x) if x.isdigit() else x
                         for x in attribute.split('.')]
        else:
            attribute = [attribute]

        def attrgetter(item):
            for part in attribute:
                item = environment.getitem(item, part)
            if postprocess is not None:
                item = postprocess(item)
            return item

        return attrgetter

    def ignore_case(value):
        return value.lower() if isinstance(value, string_types) else value

    @environmentfilter
    def do_unique(environment, value, case_sensitive=False, attribute=None):
        getter = make_attrgetter(
            environment, attribute,
            postprocess=ignore_case if not case_sensitive else None
        )
        seen = set()
        for item in value:
            key = getter(item)
            if key not in seen:
                seen.add(key)
                yield item


class FilterModule(object):

    def filters(self):
        return {
            # The Ansible unique set filter replaces the default Jinja2 unique
            # filter, so make it available as admin_users_unique instead.
            'admin_users_unique': do_unique,
        }
