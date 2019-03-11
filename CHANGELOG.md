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
