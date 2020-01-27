# VERSION 0.3.0

## Base

### Changes

* [Do not take manual task success as task exection](https://github.com/Wikia/discreETLy/pull/25/files)
* [Bump DiscreETLy to Python 3.7 and update loginpass](https://github.com/Wikia/discreETLy/pull/28)
* [Replace Fandom/Wikia branding with `COMPANY_NAME`](https://github.com/Wikia/discreETLy/issues/31)
* [Make dataprovider Airflow compatible with MySQL 5.7](https://github.com/Wikia/discreETLy/issues/33)

### Fixes

* [Fix issue where ETL dashboard displayed too many icons when a DAG had some failing statuses](https://github.com/Wikia/discreETLy/pull/26)
* [Fix non-displaying icons](https://github.com/Wikia/discreETLy/issues/32)

## Plugins

### Changes

* Tables (tables managed by..): Add possibility of declaring dependency on table from another DAG [#22](https://github.com/Wikia/discreETLy/pull/23/files), [#21](https://github.com/Wikia/discreETLy/pull/21)

### Fixes

* [S3 Usage: Fixed HTML title for initialization phase](https://github.com/Wikia/discreETLy/issues/34) 
* [S3 Usage: Move S3 database so the plugin can be used as non-root user](https://github.com/Wikia/discreETLy/pull/27)

# VERSION 0.2.9

## Plugins

### Changes
* Fix rendering of page with "Tables managed by ..."

# VERSION 0.2.8

## Plugins

### Changes
* Streaming tab now shows the lag of stream consumption on time-based graph (last day/week/month)

# VERSION 0.2.7

## Base

### Fixes

* Fixed Firefox autorefresh issue on Table Descriptions and S3 Usage tabs 
* Favicon added

# VERSION 0.2.6

## Plugins

### Changes
* New plugin added: Athena Usage [(documentation)](dashboard/plugins/athena_usage/README.md)

# VERSION 0.2.5

## Base

### Changes

* Plugin manifest is changed to include the `init` fnction
* New utils: `Timer` for external system call measurment and `sizeof_fmt` for formatting human readable object sizes [(source)](https://stackoverflow.com/a/1094933/7098262)

## Plugins

### Changes
* New plugin added: S3 Usage [(documentation)](dashboard/plugins/s3_usage/README.md)

### Fixes
* Auto-refresh disabled on Table descriptions tab

# VERSION 0.2.4

This is a version with tiny changes to layout and functionality as some bugfixes. It does not introduce new features.

## Base

#### Changes

* The labels on main site are no longer `button` type so the cursor does not suggest they are clickable
* The help button on top bar with breadcrumbs now reacts to `click` event rather than `hover` event
* Changed hover behaviour when clicking clear button in search field (also changed color on hover)

#### Fixes

* Fixed link to github documentation on help button

## Plugins

### Tables descriptions

#### Changes

* By default all table details are now hidden when opening the tab
