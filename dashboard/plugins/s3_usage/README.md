# S3 Usage plugin

This plugin provides metadata on data stored in multiple S3 buckets in AWS. The main
purpose is to provide a view on:
 * inefficiently stored data (multiple small files),
 * size of each table/partition,
 * temporary data using S3 space.

The plugin configration is stored as `S3_USAGE_PARAMS` as a dictionary with the 
following parameters:
 * `buckets_regexp` - regular expression to match the buckets
 * `aws_access_key_id` and `aws_secret_access_key` - credentials to be used to communicate
   with AWS API
 * `ttl` (optional) - time to live of cached sizes (default: 24 hours)
 * `check_every` (optional) - how often to check for stale data

From the technical perspective: after the application starts, plugin starts `S3StatsRefreshTask`
that checks for buckets matching the provided regular expression. For each bucket all keys
are listed and the metadata are stored in aggregated context (in "directory" context) in 
SQLite database inside Docker container. Tab view uses REST API to retrieve the requested 
data from SQLite database and presend them in form of the directory tree and subburst
diagram.