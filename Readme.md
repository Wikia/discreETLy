# DiscreETLy

[![Build Status](https://travis-ci.org/Wikia/discreETLy.svg?branch=master)](https://travis-ci.org/Wikia/discreETLy)
[![](https://images.microbadger.com/badges/image/fandom/discreetly:0.2.9.svg)](https://microbadger.com/images/fandom/discreetly:0.2.9 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/fandom/discreetly:0.2.9.svg)](https://microbadger.com/images/fandom/discreetly:0.2.9 "Get your own version badge on microbadger.com")

**DiscreETLy** is an add-on dashboard service on top of [Apache Airflow](https://github.com/apache/incubator-airflow). It is a user friendly UI showing status of particular DAGs. Moreover, it allows the users to map Tasks within a particular DAG to tables available in any system (relational and non-relational) via friendly yaml definition. **DiscreETLy** provides fuctionality for monitoring DAGs status as well as optional communication with services such as [Prometheus](https://prometheus.io/) or [InfluxDB](https://www.influxdata.com/).

![screenshot](https://raw.githubusercontent.com/Wikia/discreETLy/master/dashboard/static/images/ui_screen.png)

## Prerequisites

Minimal setup required to run the dashboard requires `docker`. You can find docker installation instructions on
[official docker website](https://docs.docker.com/install/).

The minimal setup requires also access to Airflow MySQL instance (MySQL version should be >= 8 and allow analytical functions).

## Configuration

Before running or deploying **DiscreETLy** a configuration file needs to be provided. The template for configuration
file can be found in `config` folder: `settings.py.template`. Configuration is provided as a standard python file,
which makes it easy to define and change utilizng Python APIs. The bare minimum configuration needed for the app to run requires definition of a secret key (stub provided in template document) and connection details for Airflow database (currently only MySQL is supported).

Configuration options for InfluxDB and Prometheus are optional. If those services are not defined in configuration
file they will be simply ignored while running the app.

If environment is not specified, the application is run in DEBUG mode, so any errors will be reported on dashboard UI. If environment variable `ENV_VAR_PREFIX` is set to `PROD` or appropriate
option is changed in `settings.py` file the application will serve `500` errors as defined in dashboard [template](dashboard/blueprints/page/templates/500.html).

## Views & Plugins

The basic configuration file is enough to run the dashboard, however, in order to take
full advantage of dashboard features and functionality there are some additional steps
that need to be performed. By default only **ETL** tab presents valuable information,
allowing users to monitor progress of particular Airflow DAGs and tasks. 
But you can easily enable plugins that configure new views. All plugins reside in
[plugins directory](dashboard/plugins) and are enabled if the plugin name is present
in the `ENABLED_PLUGINS` in the `settings.py`.

You can find more details on what each plugin provides and how to configure it 
in the following docs:

* [Tables](dashboard/plugins/tables/README.md) - tables list: status monitoring and
  records count
* [Reports](dashboard/plugins/reports/README.md) - monitoring of the reports external 
  to the Aiflow DAGs (like Tableu, Mode)
* [Streaming](dashboard/plugins/streaming/README.md) - view on non-Airflow based
  streaming applications
* [Table Descritpions](dashboard/plugins/table_descriptions/README.md) - table and
  columns description
* [S3 Usage](dashboard/plugins/s3_usage/README.md) - browser of the aggregated metadata
  of files stored inside mutliple S3 buckets
* [Athena Usage](dashboard/plugins/athena_usage/README.md) - summaries
  of users' queries data consumption to Athena
* [Hello World](dashboard/plugins/hello_world/README.md) - DiscreETLy Developers Docs


## Running locally

See: https://hub.docker.com/r/fandom/discreetly/

Before running the container with app we first need to build it so it becomes available
in our local docker repository. Run the following command from project's root directory.

```bash
docker build -t <image_name>:<image_version> .
```

Once the image is build the application can be triggered by running:

```bash
docker run -e <env_name>=<env_value> --rm --name <container_name> -v <project_root_folder>:/app -p 8000:8000 <docker_image_name>:<image_version>
```

Let's dissect this command option by option:

- `-e` flag allows to set up different evnvironment varaibles required to e.g. configure the app. Most of those options can be hardcoded in configuration file, however, passing them through environment is recommended. For more detials see **[configuration](#configuration)** section of this README.
- `--rm` removes the container after stopping it. It ensures that there is always a fresh version of conpfiguration and other features while running the app.
- `-v` maps folders containing application from local environment to container. It ensures that if in development mode all changes applied to files on local file system are immediately reflected in container.
- `-p` maps a port from container to `localhost`

If some of the configuration options are already available through `settings.py` file the command for running the application can be significantly abbreviated (from project root folder):

```bash
docker run --rm -v $(pwd):/app -p 8000:8000 fandom/discreetly:latest
```

Remember to use docker image name and version provided during `build` stage.

Once the container is ready and running navigate to `localhost:8000` in a browser and enjoy.

### Testing

In order to run the tests a docker image needs to be build first. The Dockerfile is available in `dashboard/tests/` folder. To build an image one can run the following command from project's root directory:

```bash
docker build -t dashboard:tests -f dashboard/tests/Dockerfile .
```

Once the image is build the tests can be preformed by typing

```bash
docker run --rm dashboard:tests
```

The output of this command shows a nicely formatted information of number of tests performed and success ratio (all tests are performed by using `pytest` package).

If working iteratively rebuilding the image everytime some changes are made would be cumbersome. In order to avoid that one can pass additional parameter to subsequent runs (mapping of a local project folder to container destination):

```bash
docker run --rm -v <absolute_path_to_project_root_directory>:/tmp/dashboard/ dashboard:tests
```

## Credits

* Concept & Product Design: 
[JoannaBorun](https://github.com/JoannaBorun)
* Development
[esthomw](https://github.com/esthomw)
[jcellary](https://github.com/jcellary)
[szczeles](https://github.com/szczeles)
[MikolajBalcerek](https://github.com/MikolajBalcerek)
* QA
[klistiano](https://github.com/klistiano)
