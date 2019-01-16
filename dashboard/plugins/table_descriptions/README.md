# Table descriptions View

The table descriptions tab displays table and column descriptions (comments). This can be useful for stakeholders to better understand your data structure and search for particular information. The default implementation takes them from AWS glue which stores comments added during table creation. Since not all tables have to have comments provided, this tab is fully optional.
 
It's possible to set a custom data provider which reads the table descriptions from a different source than AWS glue. This is controlled by the `TABLE_DESCRIPTION_SERVICE` setting. 

Table descriptions plugin requires valid [tables.yaml](../tables/tables.yaml.template) to be
provided to provide a subset of the tables to be displayed.

![table descriptions](table_descriptions.png)