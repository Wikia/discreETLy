# Athena Usage plugin

This *dummy* plugin describes how to contribute to DiscreETLy by creating new plugins.
Enable it in `settings.py` to find more!

Requires this dict in `settings.py`:
```
ATHENA_USAGE_PARAMS = {
    'QUERIES_TABLE': '.....', // ( DynamoDB table name)
    'aws_access_key_id': '......',
    'aws_secret_access_key': '....',
    'SQS_QUEUE_URL':  '.....'
}
```

SQS_QUEUE_URL - note that you need to specify
this before that queue has been actually created. If in doubt you can always leave it empty and then update in
lambda aws console with the created url after cloudformation has run.