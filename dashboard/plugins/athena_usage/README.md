# Athena Usage plugin

This plugin shows summarised daily, weekly and monthly data usage in Athena queries for an `executing_user`.

Relies on accessing `QUERIES_TABLE`, storing queries' info.

Requires this dict in `settings.py`:
```
ATHENA_USAGE_PARAMS = {
    'QUERIES_TABLE': '....',
    'region_name': '....',
    'aws_access_key_id': '....',
    'aws_secret_access_key': '....'}
```

