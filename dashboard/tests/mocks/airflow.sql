CREATE TABLE `dag` (
  `dag_id` varchar(250) NOT NULL,
  `is_paused` tinyint(1) DEFAULT NULL,
  `is_subdag` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `last_scheduler_run` timestamp(6) NULL DEFAULT NULL,
  `last_pickled` timestamp(6) NULL DEFAULT NULL,
  `last_expired` timestamp(6) NULL DEFAULT NULL,
  `scheduler_lock` tinyint(1) DEFAULT NULL,
  `pickle_id` int(11) DEFAULT NULL,
  `fileloc` varchar(2000) DEFAULT NULL,
  `owners` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`dag_id`)
);

INSERT INTO dag(dag_id, is_paused, is_active) VALUES ('clickstream_view_special_v2.2', 0, 1);
INSERT INTO dag(dag_id, is_paused, is_active) VALUES ('operative_data_import_v2.0', 0, 1);
INSERT INTO dag(dag_id, is_paused, is_active) VALUES ('heartbeat_v2.0', 0, 1);
INSERT INTO dag(dag_id, is_paused, is_active) VALUES ('paused_dag_v2.0', 1, 0);
INSERT INTO dag(dag_id, is_paused, is_active) VALUES ('inactive_dag_v2.0', 0, 0);


CREATE TABLE `dag_run` (
  `id` int(11) NOT NULL,
  `dag_id` varchar(250) DEFAULT NULL,
  `execution_date` timestamp(6) NULL DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `run_id` varchar(250) DEFAULT NULL,
  `external_trigger` tinyint(1) DEFAULT NULL,
  `conf` blob,
  `end_date` timestamp(6) NULL DEFAULT NULL,
  `start_date` timestamp(6) NULL DEFAULT NULL
);
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(2, 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', 'success', 'scheduled__2018-11-06T01:15:00+00:00', 0, NULL, NULL, '2018-11-07 21:46:50.846');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(5, 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', 'success', 'scheduled__2018-11-07T01:15:00+00:00', 0, NULL, NULL, '2018-11-08 08:05:39.697');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(167, 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', 'success', 'scheduled__2018-11-08T01:15:00+00:00', 0, NULL, NULL, '2018-11-09 02:15:05.741');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(286, 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', 'success', 'scheduled__2018-11-09T01:15:00+00:00', 0, NULL, NULL, '2018-11-10 02:15:00.746');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(405, 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', 'success', 'scheduled__2018-11-10T01:15:00+00:00', 0, NULL, NULL, '2018-11-12 10:11:07.461');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(524, 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', 'success', 'scheduled__2018-11-11T01:15:00+00:00', 0, NULL, NULL, '2018-11-12 02:15:03.660');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(643, 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', 'failure', 'scheduled__2018-11-12T01:15:00+00:00', 0, NULL, NULL, '2018-11-13 09:11:05.990');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(208, 'operative_data_import_v2.0', '2018-11-08 10:00:00.000', 'success', 'scheduled__2018-11-08T09:00:00+00:00', 0, NULL, NULL, '2018-11-09 10:00:04.183');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(328, 'operative_data_import_v2.0', '2018-11-09 10:00:00.000', 'success', 'scheduled__2018-11-09T09:00:00+00:00', 0, NULL, NULL, '2018-11-10 10:00:05.254');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(446, 'operative_data_import_v2.0', '2018-11-10 10:00:00.000', 'success', 'scheduled__2018-11-10T09:00:00+00:00', 0, NULL, NULL, '2018-11-11 10:00:04.640');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(566, 'operative_data_import_v2.0', '2018-11-11 10:00:00.000', 'success', 'scheduled__2018-11-11T09:00:00+00:00', 0, NULL, NULL, '2018-11-12 10:00:04.563');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(686, 'operative_data_import_v2.0', '2018-11-12 10:00:00.000', 'success', 'scheduled__2018-11-12T09:00:00+00:00', 0, NULL, NULL, '2018-11-13 10:00:10.033');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(1000, 'heartbeat_v2.0', '2018-11-12 10:00:00.000', 'success', 'scheduled__2018-11-12T09:00:00+00:00', 0, NULL, NULL, '2018-11-13 10:00:10.033');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(2000, 'paused_dag_v2.0', '2018-11-12 10:00:00.000', 'success', 'scheduled__2018-11-12T09:00:00+00:00', 0, NULL, NULL, '2018-11-13 10:00:10.033');
INSERT INTO dag_run
(id, dag_id, execution_date, state, run_id, external_trigger, conf, end_date, start_date)
VALUES(3000, 'inactive_dag_v2.0', '2018-11-12 10:00:00.000', 'success', 'scheduled__2018-11-12T09:00:00+00:00', 0, NULL, NULL, '2018-11-13 10:00:10.033');


CREATE TABLE task_instance (
  task_id varchar(250) NOT NULL,
  dag_id varchar(250) NOT NULL,
  execution_date timestamp(6) NOT NULL,
  start_date timestamp(6) NULL DEFAULT NULL,
  end_date timestamp(6) NULL DEFAULT NULL,
  duration float DEFAULT NULL,
  state varchar(20) DEFAULT NULL,
  try_number int(11) DEFAULT NULL,
  hostname varchar(1000) DEFAULT NULL,
  unixname varchar(1000) DEFAULT NULL,
  job_id int(11) DEFAULT NULL,
  pool varchar(50) DEFAULT NULL,
  queue varchar(50) DEFAULT NULL,
  priority_weight int(11) DEFAULT NULL,
  operator varchar(1000) DEFAULT NULL,
  queued_dttm timestamp(6) NULL DEFAULT NULL,
  pid int(11) DEFAULT NULL,
  max_tries int(11) DEFAULT '-1',
  executor_config blob
);

INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('analyze_google_trends', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:02:07.945', '2018-11-07 12:09:23.966', 436.021, 'success', 1, 'ca61a2f4ab13', 'airflow', 188, NULL, 'default', 2, 'SSHOperator', '2018-11-07 12:02:06.351', 1015, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('analyze_google_trends', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:39:31.736', '2018-11-08 04:45:49.056', 377.321, 'success', 1, '6a0f258e32e2', 'airflow', 419, NULL, 'default', 2, 'SSHOperator', '2018-11-08 04:39:30.213', 1052, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('analyze_google_trends', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:07:53.813', '2018-11-09 04:15:10.886', 437.073, 'success', 1, '6a0f258e32e2', 'airflow', 1714, NULL, 'default', 2, 'SSHOperator', '2018-11-09 04:07:52.405', 1999, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('analyze_google_trends', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:53:31.609', '2018-11-10 04:00:40.038', 428.429, 'success', 1, 'a8d6517382cf', 'airflow', 3237, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:53:29.708', 22144, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('analyze_google_trends', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:29:23.143', '2018-11-11 05:36:17.294', 414.15, 'success', 1, 'a8d6517382cf', 'airflow', 4222, NULL, 'default', 2, 'SSHOperator', '2018-11-11 05:29:21.450', 4073, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('analyze_google_trends', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:06:47.496', '2018-11-12 05:13:49.395', 421.899, 'success', 1, 'a8d6517382cf', 'airflow', 5119, NULL, 'default', 2, 'SSHOperator', '2018-11-12 05:06:45.406', 17506, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('analyze_google_trends', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:56:03.884', '2018-11-13 05:04:05.638', 481.754, 'success', 1, 'a8d6517382cf', 'airflow', 6023, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:56:02.311', 31180, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:57:07.557', '2018-11-07 11:57:17.450', 9.89331, 'success', 1, 'ca61a2f4ab13', 'airflow', 180, NULL, 'default', 2, 'SSHOperator', '2018-11-07 11:57:05.306', 906, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:37:45.845', '2018-11-08 04:37:53.397', 7.55221, 'success', 1, '6a0f258e32e2', 'airflow', 416, NULL, 'default', 2, 'SSHOperator', '2018-11-08 04:37:44.460', 1007, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:03:59.877', '2018-11-09 04:04:09.509', 9.63223, 'success', 1, '6a0f258e32e2', 'airflow', 1698, NULL, 'default', 2, 'SSHOperator', '2018-11-09 04:03:58.243', 1775, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:51:44.537', '2018-11-10 03:51:53.104', 8.56699, 'success', 1, 'a8d6517382cf', 'airflow', 3233, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:51:42.778', 22071, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:23:03.534', '2018-11-11 05:23:12.079', 8.54489, 'success', 1, 'a8d6517382cf', 'airflow', 4213, NULL, 'default', 2, 'SSHOperator', '2018-11-11 05:23:01.695', 3955, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:04:33.413', '2018-11-12 05:04:40.787', 7.3744, 'success', 1, 'a8d6517382cf', 'airflow', 5112, NULL, 'default', 2, 'SSHOperator', '2018-11-12 05:04:31.660', 17414, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:54:52.221', '2018-11-13 04:54:59.975', 7.75432, 'success', 1, 'a8d6517382cf', 'airflow', 6018, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:54:50.819', 31120, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:02:07.930', '2018-11-07 12:15:33.407', 805.477, 'success', 1, 'ca61a2f4ab13', 'airflow', 187, NULL, 'default', 1, 'SSHOperator', '2018-11-07 12:02:06.351', 1017, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:37:56.342', '2018-11-08 05:06:33.963', 1717.62, 'success', 1, '6a0f258e32e2', 'airflow', 418, NULL, 'default', 1, 'SSHOperator', '2018-11-08 04:37:54.995', 1037, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:04:21.258', '2018-11-09 04:15:07.554', 646.296, 'success', 1, '6a0f258e32e2', 'airflow', 1701, NULL, 'default', 1, 'SSHOperator', '2018-11-09 04:04:19.540', 1818, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:51:55.176', '2018-11-10 04:06:47.775', 892.599, 'success', 1, 'a8d6517382cf', 'airflow', 3235, NULL, 'default', 1, 'SSHOperator', '2018-11-10 03:51:53.490', 22114, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:23:13.793', '2018-11-11 05:33:07.955', 594.162, 'success', 1, 'a8d6517382cf', 'airflow', 4215, NULL, 'default', 1, 'SSHOperator', '2018-11-11 05:23:12.288', 3985, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:04:43.978', '2018-11-12 05:21:11.737', 987.76, 'success', 1, 'a8d6517382cf', 'airflow', 5114, NULL, 'default', 1, 'SSHOperator', '2018-11-12 05:04:42.457', 17444, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('crossvisitization_domain_pageview_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 09:11:12.264', '2018-11-13 09:15:46.849', 274.585, 'success', 3, 'a8d6517382cf', 'airflow', 6220, NULL, 'default', 1, 'SSHOperator', '2018-11-13 04:55:01.531', 1835, 3, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_clickstream_view_special_v2.2', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 02:18:50.856', '2018-11-07 02:20:52.322', 121.466, 'success', 1, 'ca61a2f4ab13', 'airflow', 68, NULL, 'default', 62, 'TimeDeltaSensor', '2018-11-07 02:18:49.065', 49, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_clickstream_view_special_v2.2', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:15:08.749', '2018-11-08 02:20:10.314', 301.565, 'success', 1, '6a0f258e32e2', 'airflow', 347, NULL, 'default', 62, 'TimeDeltaSensor', '2018-11-08 02:15:07.238', 194, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_clickstream_view_special_v2.2', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:15:07.645', '2018-11-09 02:20:09.204', 301.56, 'success', 1, '6a0f258e32e2', 'airflow', 1557, NULL, 'default', 62, 'TimeDeltaSensor', '2018-11-09 02:15:06.189', 32439, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_clickstream_view_special_v2.2', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:15:02.831', '2018-11-10 02:20:04.477', 301.646, 'success', 1, 'a8d6517382cf', 'airflow', 3112, NULL, 'default', 62, 'TimeDeltaSensor', '2018-11-10 02:15:01.354', 20468, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_clickstream_view_special_v2.2', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:15:11.219', '2018-11-11 02:20:13.026', 301.806, 'success', 1, 'a8d6517382cf', 'airflow', 4010, NULL, 'default', 62, 'TimeDeltaSensor', '2018-11-11 02:15:09.672', 1521, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_clickstream_view_special_v2.2', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 02:15:05.652', '2018-11-12 02:20:07.336', 301.683, 'success', 1, 'a8d6517382cf', 'airflow', 4933, NULL, 'default', 62, 'TimeDeltaSensor', '2018-11-12 02:15:04.165', 15254, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_clickstream_view_special_v2.2', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:15:05.039', '2018-11-13 02:20:06.666', 301.627, 'success', 1, 'a8d6517382cf', 'airflow', 5848, NULL, 'default', 62, 'TimeDeltaSensor', '2018-11-13 02:15:03.635', 28998, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('events_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:17:51.780', '2018-11-07 08:45:02.927', 1631.15, 'success', 1, 'ca61a2f4ab13', 'airflow', 111, NULL, 'default', 57, 'SSHOperator', '2018-11-07 08:17:50.316', 148, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('events_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:20:59.854', '2018-11-08 02:42:50.745', 1310.89, 'success', 1, '6a0f258e32e2', 'airflow', 353, NULL, 'default', 57, 'SSHOperator', '2018-11-08 02:20:58.480', 263, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('events_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:21:00.694', '2018-11-09 02:39:56.876', 1136.18, 'success', 1, '6a0f258e32e2', 'airflow', 1570, NULL, 'default', 57, 'SSHOperator', '2018-11-09 02:20:59.027', 32602, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('events_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:20:50.579', '2018-11-10 02:35:16.979', 866.4, 'success', 1, 'a8d6517382cf', 'airflow', 3118, NULL, 'default', 57, 'SSHOperator', '2018-11-10 02:20:49.071', 20550, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('events_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:21:04.509', '2018-11-11 02:56:14.485', 2109.98, 'success', 1, 'a8d6517382cf', 'airflow', 4016, NULL, 'default', 57, 'SSHOperator', '2018-11-11 02:21:03.124', 1603, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('events_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 02:21:10.512', '2018-11-12 03:11:52.349', 3041.84, 'success', 1, 'a8d6517382cf', 'airflow', 4939, NULL, 'default', 57, 'SSHOperator', '2018-11-12 02:21:09.124', 15336, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('events_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:21:09.578', '2018-11-13 02:58:20.730', 2231.15, 'success', 1, 'a8d6517382cf', 'airflow', 5854, NULL, 'default', 57, 'SSHOperator', '2018-11-13 02:21:08.116', 29080, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:39.388', '2018-11-07 09:13:15.436', 1596.05, 'success', 1, 'ca61a2f4ab13', 'airflow', 119, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 203, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:27.566', '2018-11-08 03:08:59.317', 1531.75, 'success', 1, '6a0f258e32e2', 'airflow', 366, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.901', 435, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:23.899', '2018-11-09 03:03:56.589', 1412.69, 'success', 1, '6a0f258e32e2', 'airflow', 1597, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 448, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:52.869', '2018-11-10 02:59:48.342', 1435.47, 'success', 1, 'a8d6517382cf', 'airflow', 3132, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20687, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.193', '2018-11-11 04:05:46.085', 4135.89, 'success', 1, 'a8d6517382cf', 'airflow', 4040, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 1800, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:25.140', '2018-11-12 04:03:22.770', 3057.63, 'success', 1, 'a8d6517382cf', 'airflow', 4972, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15576, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.447', '2018-11-13 03:36:25.611', 2248.16, 'success', 1, 'a8d6517382cf', 'airflow', 5878, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29282, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_pageviews', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:39.304', '2018-11-07 08:51:58.139', 318.834, 'success', 1, 'ca61a2f4ab13', 'airflow', 118, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 206, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_pageviews', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.161', '2018-11-08 02:48:58.019', 329.859, 'success', 1, '6a0f258e32e2', 'airflow', 370, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.901', 438, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_pageviews', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:23.950', '2018-11-09 02:46:52.980', 389.03, 'success', 1, '6a0f258e32e2', 'airflow', 1598, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 446, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_pageviews', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.137', '2018-11-10 02:59:02.494', 1389.36, 'success', 1, 'a8d6517382cf', 'airflow', 3134, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20689, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_pageviews', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:49.639', '2018-11-11 03:03:38.472', 408.833, 'success', 1, 'a8d6517382cf', 'airflow', 4035, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 1802, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_pageviews', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:24.112', '2018-11-12 03:40:57.366', 1713.25, 'success', 1, 'a8d6517382cf', 'airflow', 4965, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15579, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('f2_fact_pageviews', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.370', '2018-11-13 03:11:42.340', 764.97, 'success', 1, 'a8d6517382cf', 'airflow', 5877, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29280, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_abtreatment_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:40.640', '2018-11-07 09:18:40.968', 1920.33, 'success', 1, 'ca61a2f4ab13', 'airflow', 127, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 207, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_abtreatment_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.739', '2018-11-08 03:05:20.409', 1311.67, 'success', 1, '6a0f258e32e2', 'airflow', 375, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.901', 437, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_abtreatment_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:24.122', '2018-11-09 02:59:41.046', 1156.92, 'success', 1, '6a0f258e32e2', 'airflow', 1599, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 450, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_abtreatment_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.479', '2018-11-10 02:58:50.128', 1376.65, 'success', 1, 'a8d6517382cf', 'airflow', 3139, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20691, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_abtreatment_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.455', '2018-11-11 03:46:01.971', 2951.52, 'success', 1, 'a8d6517382cf', 'airflow', 4043, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 1806, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_abtreatment_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:23.799', '2018-11-12 03:41:51.729', 1767.93, 'success', 1, 'a8d6517382cf', 'airflow', 4961, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15583, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_abtreatment_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.191', '2018-11-13 03:28:06.648', 1749.46, 'success', 1, 'a8d6517382cf', 'airflow', 5874, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29283, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_event_props', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:39.967', '2018-11-07 08:47:08.959', 28.9923, 'success', 1, 'ca61a2f4ab13', 'airflow', 122, NULL, 'default', 2, 'SSHOperator', '2018-11-07 08:46:35.430', 201, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_event_props', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.761', '2018-11-08 02:43:57.129', 28.3686, 'success', 1, '6a0f258e32e2', 'airflow', 377, NULL, 'default', 2, 'SSHOperator', '2018-11-08 02:43:22.901', 431, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_event_props', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:23.840', '2018-11-09 02:40:44.997', 21.1569, 'success', 1, '6a0f258e32e2', 'airflow', 1592, NULL, 'default', 2, 'SSHOperator', '2018-11-09 02:40:20.801', 443, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_event_props', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:52.491', '2018-11-10 02:36:17.816', 25.3245, 'success', 1, 'a8d6517382cf', 'airflow', 3129, NULL, 'default', 2, 'SSHOperator', '2018-11-10 02:35:48.418', 20686, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_event_props', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.914', '2018-11-11 02:57:16.945', 26.0313, 'success', 1, 'a8d6517382cf', 'airflow', 4046, NULL, 'default', 2, 'SSHOperator', '2018-11-11 02:56:45.135', 1798, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_event_props', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:25.004', '2018-11-12 03:12:53.318', 28.3141, 'success', 1, 'a8d6517382cf', 'airflow', 4970, NULL, 'default', 2, 'SSHOperator', '2018-11-12 03:12:19.122', 15574, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_event_props', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.647', '2018-11-13 02:59:27.872', 30.2249, 'success', 1, 'a8d6517382cf', 'airflow', 5881, NULL, 'default', 2, 'SSHOperator', '2018-11-13 02:58:52.527', 29276, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 21:47:00.413', '2018-11-08 00:48:14.712', 10874.3, 'success', 11, '6a0f258e32e2', 'airflow', 309, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:53:29.596', 36, 11, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 08:05:47.976', '2018-11-08 11:54:29.068', 13721.1, 'success', 3, '6a0f258e32e2', 'airflow', 492, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:57.505', 1833, 3, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:49:40.691', '2018-11-09 05:50:43.381', 10862.7, 'success', 1, '6a0f258e32e2', 'airflow', 1607, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:53.965', 660, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:36:24.897', '2018-11-10 05:40:14.326', 11029.4, 'success', 1, 'a8d6517382cf', 'airflow', 3145, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:36:22.857', 20917, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-12 10:11:12.422', '2018-11-12 12:39:54.744', 8922.32, 'success', 3, 'a8d6517382cf', 'airflow', 5344, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:57:19.611', 21019, 3, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:13:04.841', '2018-11-12 07:07:32.055', 14067.2, 'success', 1, 'a8d6517382cf', 'airflow', 4974, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:13:03.259', 15776, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengadinfo_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:59:41.004', '2018-11-13 06:43:56.069', 13455.1, 'success', 1, 'a8d6517382cf', 'airflow', 5885, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:59:37.345', 29477, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengpageinfo_props_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:39.941', '2018-11-07 09:14:16.524', 1656.58, 'success', 1, 'ca61a2f4ab13', 'airflow', 123, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 211, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengpageinfo_props_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.480', '2018-11-08 03:15:03.597', 1895.12, 'success', 1, '6a0f258e32e2', 'airflow', 372, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.901', 442, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengpageinfo_props_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:23.866', '2018-11-09 03:16:04.972', 2141.11, 'success', 1, '6a0f258e32e2', 'airflow', 1594, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 452, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengpageinfo_props_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:52.859', '2018-11-10 02:55:57.904', 1205.05, 'success', 1, 'a8d6517382cf', 'airflow', 3131, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20693, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengpageinfo_props_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:49.344', '2018-11-11 04:00:31.002', 3821.66, 'success', 1, 'a8d6517382cf', 'airflow', 4033, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 1808, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengpageinfo_props_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:24.874', '2018-11-12 03:51:44.778', 2359.9, 'success', 1, 'a8d6517382cf', 'airflow', 4969, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15586, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengpageinfo_props_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.329', '2018-11-13 03:21:46.377', 1369.05, 'success', 1, 'a8d6517382cf', 'airflow', 5875, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29285, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengplayerinfo_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:39.897', '2018-11-07 09:55:42.398', 4142.5, 'success', 1, 'ca61a2f4ab13', 'airflow', 121, NULL, 'default', 3, 'SSHOperator', '2018-11-07 08:46:35.430', 199, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengplayerinfo_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:27.945', '2018-11-08 03:42:15.758', 3527.81, 'success', 1, '6a0f258e32e2', 'airflow', 368, NULL, 'default', 3, 'SSHOperator', '2018-11-08 02:43:22.901', 433, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengplayerinfo_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:23.910', '2018-11-09 03:31:13.731', 3049.82, 'success', 1, '6a0f258e32e2', 'airflow', 1595, NULL, 'default', 3, 'SSHOperator', '2018-11-09 02:40:20.801', 441, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengplayerinfo_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.215', '2018-11-10 03:32:55.394', 3422.18, 'success', 1, 'a8d6517382cf', 'airflow', 3135, NULL, 'default', 3, 'SSHOperator', '2018-11-10 02:35:48.418', 20683, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengplayerinfo_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:49.428', '2018-11-11 04:10:57.654', 4448.23, 'success', 1, 'a8d6517382cf', 'airflow', 4034, NULL, 'default', 3, 'SSHOperator', '2018-11-11 02:56:45.135', 1796, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengplayerinfo_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:24.270', '2018-11-12 04:43:23.636', 5459.37, 'success', 1, 'a8d6517382cf', 'airflow', 4966, NULL, 'default', 3, 'SSHOperator', '2018-11-12 03:12:19.122', 15573, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengplayerinfo_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.107', '2018-11-13 04:00:49.323', 3712.22, 'success', 1, 'a8d6517382cf', 'airflow', 5872, NULL, 'default', 3, 'SSHOperator', '2018-11-13 02:58:52.527', 29273, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengviewability_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:41.577', '2018-11-07 09:05:01.422', 1099.84, 'success', 1, 'ca61a2f4ab13', 'airflow', 131, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 216, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengviewability_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.774', '2018-11-08 03:01:07.262', 1058.49, 'success', 1, '6a0f258e32e2', 'airflow', 374, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.901', 444, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengviewability_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:23.915', '2018-11-09 03:06:11.402', 1547.49, 'success', 1, '6a0f258e32e2', 'airflow', 1596, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 453, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengviewability_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.210', '2018-11-10 03:05:21.300', 1768.09, 'success', 1, 'a8d6517382cf', 'airflow', 3136, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20695, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengviewability_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.918', '2018-11-11 03:39:09.657', 2538.74, 'success', 1, 'a8d6517382cf', 'airflow', 4044, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 1810, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengviewability_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:23.908', '2018-11-12 03:36:37.752', 1453.84, 'success', 1, 'a8d6517382cf', 'airflow', 4964, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15589, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_adengviewability_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:58.116', '2018-11-13 03:49:55.765', 3057.65, 'success', 1, 'a8d6517382cf', 'airflow', 5882, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29288, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:40.744', '2018-11-07 09:23:50.160', 2229.42, 'success', 1, 'ca61a2f4ab13', 'airflow', 129, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 215, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.684', '2018-11-08 03:58:34.069', 4505.39, 'success', 1, '6a0f258e32e2', 'airflow', 376, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.901', 446, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:48.347', '2018-11-09 03:45:36.558', 3888.21, 'success', 1, '6a0f258e32e2', 'airflow', 1602, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 585, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.314', '2018-11-10 03:30:34.465', 3281.15, 'success', 1, 'a8d6517382cf', 'airflow', 3138, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20697, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.365', '2018-11-11 04:17:23.521', 4833.16, 'success', 1, 'a8d6517382cf', 'airflow', 4041, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 1812, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:23.551', '2018-11-12 04:30:55.380', 4711.83, 'success', 1, 'a8d6517382cf', 'airflow', 4960, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15588, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.107', '2018-11-13 04:08:42.260', 4185.15, 'success', 1, 'a8d6517382cf', 'airflow', 5873, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29286, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_pageviews', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:40.601', '2018-11-07 09:35:03.758', 2903.16, 'success', 1, 'ca61a2f4ab13', 'airflow', 128, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 218, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_pageviews', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:29.126', '2018-11-08 03:17:43.875', 2054.75, 'success', 1, '6a0f258e32e2', 'airflow', 379, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.901', 445, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_pageviews', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:46:56.974', '2018-11-09 03:41:35.544', 3278.57, 'success', 1, '6a0f258e32e2', 'airflow', 1603, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 600, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_pageviews', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.267', '2018-11-10 03:32:31.575', 3398.31, 'success', 1, 'a8d6517382cf', 'airflow', 3137, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20699, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_pageviews', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.151', '2018-11-11 04:13:45.188', 4615.04, 'success', 1, 'a8d6517382cf', 'airflow', 4039, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 1814, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_pageviews', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:24.419', '2018-11-12 04:19:24.704', 4020.28, 'success', 1, 'a8d6517382cf', 'airflow', 4967, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15590, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_fandomcreator_pageviews', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:59.179', '2018-11-13 04:05:33.400', 3994.22, 'success', 1, 'a8d6517382cf', 'airflow', 5884, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29289, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_gdpr_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:40.513', '2018-11-07 09:42:59.967', 3379.45, 'success', 1, 'ca61a2f4ab13', 'airflow', 126, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 217, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_gdpr_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.215', '2018-11-08 03:31:13.802', 2865.59, 'success', 1, '6a0f258e32e2', 'airflow', 371, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.901', 449, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_gdpr_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:47:50.571', '2018-11-09 03:43:50.447', 3359.88, 'success', 1, '6a0f258e32e2', 'airflow', 1604, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 615, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_gdpr_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.624', '2018-11-10 03:35:50.271', 3596.65, 'success', 1, 'a8d6517382cf', 'airflow', 3142, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20701, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_gdpr_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.903', '2018-11-11 04:12:14.769', 4523.87, 'success', 1, 'a8d6517382cf', 'airflow', 4045, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 1815, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_gdpr_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:24.507', '2018-11-12 04:36:59.640', 5075.13, 'success', 1, 'a8d6517382cf', 'airflow', 4968, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15591, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_gdpr_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.661', '2018-11-13 04:13:39.519', 4481.86, 'success', 1, 'a8d6517382cf', 'airflow', 5880, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29293, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_pageview_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:59:39.440', '2018-11-07 11:16:01.146', 4581.71, 'success', 2, 'ca61a2f4ab13', 'airflow', 147, NULL, 'default', 29, 'SSHOperator', '2018-11-07 08:46:35.430', 523, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_pageview_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:27.887', '2018-11-08 03:54:31.798', 4263.91, 'success', 1, '6a0f258e32e2', 'airflow', 367, NULL, 'default', 29, 'SSHOperator', '2018-11-08 02:43:22.901', 424, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_pageview_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:23.858', '2018-11-09 03:54:32.792', 4448.93, 'success', 1, '6a0f258e32e2', 'airflow', 1593, NULL, 'default', 29, 'SSHOperator', '2018-11-09 02:40:20.801', 435, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_pageview_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:52.833', '2018-11-10 03:41:09.987', 3917.15, 'success', 1, 'a8d6517382cf', 'airflow', 3130, NULL, 'default', 29, 'SSHOperator', '2018-11-10 02:35:48.418', 20677, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_pageview_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.435', '2018-11-11 05:11:25.404', 8074.97, 'success', 1, 'a8d6517382cf', 'airflow', 4042, NULL, 'default', 29, 'SSHOperator', '2018-11-11 02:56:45.135', 1790, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_pageview_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:23.916', '2018-11-12 04:50:50.287', 5906.37, 'success', 1, 'a8d6517382cf', 'airflow', 4962, NULL, 'default', 29, 'SSHOperator', '2018-11-12 03:12:19.122', 15566, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_pageview_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.331', '2018-11-13 04:41:19.010', 6141.68, 'success', 1, 'a8d6517382cf', 'airflow', 5876, NULL, 'default', 29, 'SSHOperator', '2018-11-13 02:58:52.527', 29267, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_search_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:40.046', '2018-11-07 09:05:49.901', 1149.86, 'success', 1, 'ca61a2f4ab13', 'airflow', 124, NULL, 'default', 4, 'SSHOperator', '2018-11-07 08:46:35.430', 197, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_search_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.117', '2018-11-08 03:14:46.305', 1878.19, 'success', 1, '6a0f258e32e2', 'airflow', 369, NULL, 'default', 4, 'SSHOperator', '2018-11-08 02:43:22.901', 428, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_search_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:24.259', '2018-11-09 03:13:28.125', 1983.87, 'success', 1, '6a0f258e32e2', 'airflow', 1601, NULL, 'default', 4, 'SSHOperator', '2018-11-09 02:40:20.801', 439, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_search_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.559', '2018-11-10 02:58:41.440', 1367.88, 'success', 1, 'a8d6517382cf', 'airflow', 3140, NULL, 'default', 4, 'SSHOperator', '2018-11-10 02:35:48.418', 20681, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_search_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.048', '2018-11-11 03:26:56.849', 1806.8, 'success', 1, 'a8d6517382cf', 'airflow', 4037, NULL, 'default', 4, 'SSHOperator', '2018-11-11 02:56:45.135', 1794, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_search_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:25.136', '2018-11-12 03:45:37.118', 1991.98, 'success', 1, 'a8d6517382cf', 'airflow', 4973, NULL, 'default', 4, 'SSHOperator', '2018-11-12 03:12:19.122', 15570, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_search_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.527', '2018-11-13 03:41:44.462', 2566.93, 'success', 1, 'a8d6517382cf', 'airflow', 5879, NULL, 'default', 4, 'SSHOperator', '2018-11-13 02:58:52.527', 29271, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_trackingevent_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:40.916', '2018-11-07 09:40:28.680', 3227.76, 'success', 1, 'ca61a2f4ab13', 'airflow', 130, NULL, 'default', 7, 'SSHOperator', '2018-11-07 08:46:35.430', 195, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_trackingevent_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.741', '2018-11-08 03:19:21.920', 2153.18, 'success', 1, '6a0f258e32e2', 'airflow', 373, NULL, 'default', 7, 'SSHOperator', '2018-11-08 02:43:22.901', 426, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_trackingevent_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:24.271', '2018-11-09 03:36:14.997', 3350.73, 'success', 1, '6a0f258e32e2', 'airflow', 1600, NULL, 'default', 7, 'SSHOperator', '2018-11-09 02:40:20.801', 437, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_trackingevent_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:52.953', '2018-11-10 03:08:48.263', 1975.31, 'success', 1, 'a8d6517382cf', 'airflow', 3133, NULL, 'default', 7, 'SSHOperator', '2018-11-10 02:35:48.418', 20679, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_trackingevent_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:50.199', '2018-11-11 04:02:43.806', 3953.61, 'success', 1, 'a8d6517382cf', 'airflow', 4038, NULL, 'default', 7, 'SSHOperator', '2018-11-11 02:56:45.135', 1792, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_trackingevent_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:25.095', '2018-11-12 04:22:27.940', 4202.84, 'success', 1, 'a8d6517382cf', 'airflow', 4971, NULL, 'default', 7, 'SSHOperator', '2018-11-12 03:12:19.122', 15568, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_trackingevent_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:57.131', '2018-11-13 04:07:23.975', 4106.84, 'success', 1, 'a8d6517382cf', 'airflow', 5871, NULL, 'default', 7, 'SSHOperator', '2018-11-13 02:58:52.527', 29269, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_videoplayer_events', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:46:39.642', '2018-11-07 09:17:37.607', 1857.96, 'success', 1, 'ca61a2f4ab13', 'airflow', 120, NULL, 'default', 1, 'SSHOperator', '2018-11-07 08:46:35.430', 219, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_videoplayer_events', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:28.786', '2018-11-08 03:12:50.736', 1761.95, 'success', 1, '6a0f258e32e2', 'airflow', 378, NULL, 'default', 1, 'SSHOperator', '2018-11-08 02:43:22.902', 450, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_videoplayer_events', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:48:20.558', '2018-11-09 03:45:49.734', 3449.18, 'success', 1, '6a0f258e32e2', 'airflow', 1605, NULL, 'default', 1, 'SSHOperator', '2018-11-09 02:40:20.801', 630, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_videoplayer_events', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:53.582', '2018-11-10 03:03:02.400', 1628.82, 'success', 1, 'a8d6517382cf', 'airflow', 3141, NULL, 'default', 1, 'SSHOperator', '2018-11-10 02:35:48.418', 20703, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_videoplayer_events', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:12:45.663', '2018-11-11 04:46:59.109', 2053.45, 'success', 2, 'a8d6517382cf', 'airflow', 4137, NULL, 'default', 1, 'SSHOperator', '2018-11-11 02:56:45.135', 2947, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_videoplayer_events', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:12:23.874', '2018-11-12 04:09:48.081', 3444.21, 'success', 1, 'a8d6517382cf', 'airflow', 4963, NULL, 'default', 1, 'SSHOperator', '2018-11-12 03:12:19.122', 15592, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('fact_videoplayer_events', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:58.159', '2018-11-13 03:41:14.387', 2536.23, 'success', 1, 'a8d6517382cf', 'airflow', 5883, NULL, 'default', 1, 'SSHOperator', '2018-11-13 02:58:52.527', 29292, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('put_google_trends_to_athena', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:12:23.241', '2018-11-07 12:16:15.588', 232.348, 'success', 1, 'ca61a2f4ab13', 'airflow', 193, NULL, 'default', 1, 'SSHOperator', '2018-11-07 12:12:19.857', 1116, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('put_google_trends_to_athena', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:46:01.126', '2018-11-08 04:55:30.837', 569.711, 'success', 1, '6a0f258e32e2', 'airflow', 425, NULL, 'default', 1, 'SSHOperator', '2018-11-08 04:45:59.697', 1127, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('put_google_trends_to_athena', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:15:14.865', '2018-11-09 04:18:41.353', 206.489, 'success', 1, '6a0f258e32e2', 'airflow', 1718, NULL, 'default', 1, 'SSHOperator', '2018-11-09 04:15:13.462', 2044, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('put_google_trends_to_athena', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 04:00:50.548', '2018-11-10 04:08:29.225', 458.677, 'success', 1, 'a8d6517382cf', 'airflow', 3243, NULL, 'default', 1, 'SSHOperator', '2018-11-10 04:00:49.014', 22217, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('put_google_trends_to_athena', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:36:21.099', '2018-11-11 05:37:55.618', 94.519, 'success', 1, 'a8d6517382cf', 'airflow', 4227, NULL, 'default', 1, 'SSHOperator', '2018-11-11 05:36:19.702', 4148, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('put_google_trends_to_athena', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:14:00.512', '2018-11-12 05:23:35.579', 575.066, 'success', 1, 'a8d6517382cf', 'airflow', 5123, NULL, 'default', 1, 'SSHOperator', '2018-11-12 05:13:58.703', 17564, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('put_google_trends_to_athena', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 05:04:09.644', '2018-11-13 05:13:04.309', 534.665, 'success', 1, 'a8d6517382cf', 'airflow', 6026, NULL, 'default', 1, 'SSHOperator', '2018-11-13 05:04:08.128', 31223, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('raw_events_s3_sensor', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 02:28:58.509', '2018-11-07 02:29:00.687', 2.17779, 'success', 1, 'ca61a2f4ab13', 'airflow', 71, NULL, 'default', 60, 'S3KeySensor', '2018-11-07 02:28:57.042', 75, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('raw_events_s3_sensor', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:20:27.190', '2018-11-08 02:20:29.375', 2.18482, 'success', 1, '6a0f258e32e2', 'airflow', 350, NULL, 'default', 60, 'S3KeySensor', '2018-11-08 02:20:25.689', 220, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('raw_events_s3_sensor', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:20:28.488', '2018-11-09 02:20:30.598', 2.11075, 'success', 1, '6a0f258e32e2', 'airflow', 1565, NULL, 'default', 60, 'S3KeySensor', '2018-11-09 02:20:26.441', 32529, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('raw_events_s3_sensor', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:20:17.962', '2018-11-10 02:20:20.051', 2.08837, 'success', 1, 'a8d6517382cf', 'airflow', 3115, NULL, 'default', 60, 'S3KeySensor', '2018-11-10 02:20:16.467', 20507, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('raw_events_s3_sensor', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:20:32.384', '2018-11-11 02:20:34.799', 2.41548, 'success', 1, 'a8d6517382cf', 'airflow', 4013, NULL, 'default', 60, 'S3KeySensor', '2018-11-11 02:20:30.971', 1560, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('raw_events_s3_sensor', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 02:20:29.217', '2018-11-12 02:20:33.760', 4.54313, 'success', 1, 'a8d6517382cf', 'airflow', 4936, NULL, 'default', 60, 'S3KeySensor', '2018-11-12 02:20:25.671', 15293, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('raw_events_s3_sensor', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:20:28.619', '2018-11-13 02:20:33.481', 4.86189, 'success', 1, 'a8d6517382cf', 'airflow', 5851, NULL, 'default', 60, 'S3KeySensor', '2018-11-13 02:20:25.227', 29037, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:59:39.522', '2018-11-07 09:59:46.399', 6.87604, 'success', 1, 'ca61a2f4ab13', 'airflow', 148, NULL, 'default', 2, 'SSHOperator', '2018-11-07 09:59:37.902', 525, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:42:27.622', '2018-11-08 03:42:33.943', 6.32107, 'success', 1, '6a0f258e32e2', 'airflow', 395, NULL, 'default', 2, 'SSHOperator', '2018-11-08 03:42:25.703', 769, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:31:23.934', '2018-11-09 03:31:30.386', 6.45121, 'success', 1, '6a0f258e32e2', 'airflow', 1658, NULL, 'default', 2, 'SSHOperator', '2018-11-09 03:31:22.183', 1252, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:33:01.947', '2018-11-10 03:33:09.196', 7.24809, 'success', 1, 'a8d6517382cf', 'airflow', 3192, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:33:00.159', 21490, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:13:47.797', '2018-11-11 04:13:54.122', 6.32508, 'success', 1, 'a8d6517382cf', 'airflow', 4138, NULL, 'default', 2, 'SSHOperator', '2018-11-11 04:10:58.751', 2962, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:43:26.474', '2018-11-12 04:43:32.852', 6.37876, 'success', 1, 'a8d6517382cf', 'airflow', 5088, NULL, 'default', 2, 'SSHOperator', '2018-11-12 04:43:25.077', 17092, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:05:33.353', '2018-11-13 04:05:40.186', 6.83394, 'success', 1, 'a8d6517382cf', 'airflow', 5953, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:00:52.535', 30232, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 10:04:58.420', '2018-11-07 10:16:46.534', 708.114, 'success', 1, 'ca61a2f4ab13', 'airflow', 150, NULL, 'default', 1, 'SSHOperator', '2018-11-07 10:04:54.896', 553, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:42:38.274', '2018-11-08 03:59:34.142', 1015.87, 'success', 1, '6a0f258e32e2', 'airflow', 396, NULL, 'default', 1, 'SSHOperator', '2018-11-08 03:42:36.483', 784, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:31:34.328', '2018-11-09 03:44:25.480', 771.152, 'success', 1, '6a0f258e32e2', 'airflow', 1659, NULL, 'default', 1, 'SSHOperator', '2018-11-09 03:31:32.810', 1267, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:33:42.028', '2018-11-10 03:37:06.171', 204.143, 'success', 1, 'a8d6517382cf', 'airflow', 3195, NULL, 'default', 1, 'SSHOperator', '2018-11-10 03:33:10.875', 21537, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:14:13.541', '2018-11-11 04:43:46.742', 1773.2, 'success', 1, 'a8d6517382cf', 'airflow', 4143, NULL, 'default', 1, 'SSHOperator', '2018-11-11 04:14:03.282', 3035, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:43:37.501', '2018-11-12 04:46:42.238', 184.737, 'success', 1, 'a8d6517382cf', 'airflow', 5089, NULL, 'default', 1, 'SSHOperator', '2018-11-12 04:43:35.839', 17107, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_adengplayerinfo_events_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:06:34.366', '2018-11-13 04:18:32.757', 718.391, 'success', 1, 'a8d6517382cf', 'airflow', 5958, NULL, 'default', 1, 'SSHOperator', '2018-11-13 04:05:42.007', 30297, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:44:25.479', '2018-11-07 09:44:32.184', 6.70547, 'success', 1, 'ca61a2f4ab13', 'airflow', 143, NULL, 'default', 2, 'SSHOperator', '2018-11-07 09:44:23.820', 465, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:19:31.481', '2018-11-08 03:19:38.016', 6.53495, 'success', 1, '6a0f258e32e2', 'airflow', 387, NULL, 'default', 2, 'SSHOperator', '2018-11-08 03:19:29.916', 681, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:36:21.894', '2018-11-09 03:36:28.643', 6.74941, 'success', 1, '6a0f258e32e2', 'airflow', 1670, NULL, 'default', 2, 'SSHOperator', '2018-11-09 03:36:20.257', 1403, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:08:58.622', '2018-11-10 03:09:06.139', 7.51742, 'success', 1, 'a8d6517382cf', 'airflow', 3157, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:08:56.947', 21037, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:06:50.189', '2018-11-11 04:06:56.401', 6.21163, 'success', 1, 'a8d6517382cf', 'airflow', 4124, NULL, 'default', 2, 'SSHOperator', '2018-11-11 04:02:47.372', 2802, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:24:09.933', '2018-11-12 04:24:16.551', 6.61885, 'success', 1, 'a8d6517382cf', 'airflow', 5056, NULL, 'default', 2, 'SSHOperator', '2018-11-12 04:22:31.347', 16663, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:08:22.937', '2018-11-13 04:08:29.892', 6.95582, 'success', 1, 'a8d6517382cf', 'airflow', 5963, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:07:31.573', 30370, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:49:25.948', '2018-11-07 10:00:07.396', 641.448, 'success', 1, 'ca61a2f4ab13', 'airflow', 144, NULL, 'default', 1, 'SSHOperator', '2018-11-07 09:49:24.573', 495, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:19:42.196', '2018-11-08 03:34:39.301', 897.106, 'success', 1, '6a0f258e32e2', 'airflow', 389, NULL, 'default', 1, 'SSHOperator', '2018-11-08 03:19:40.594', 711, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:36:32.600', '2018-11-09 03:47:13.429', 640.829, 'success', 1, '6a0f258e32e2', 'airflow', 1671, NULL, 'default', 1, 'SSHOperator', '2018-11-09 03:36:30.970', 1433, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:09:09.241', '2018-11-10 03:37:47.627', 1718.39, 'success', 1, 'a8d6517382cf', 'airflow', 3158, NULL, 'default', 1, 'SSHOperator', '2018-11-10 03:09:07.669', 21067, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:12:31.422', '2018-11-11 04:20:02.549', 451.126, 'success', 1, 'a8d6517382cf', 'airflow', 4135, NULL, 'default', 1, 'SSHOperator', '2018-11-11 04:06:59.822', 2919, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:25:44.020', '2018-11-12 04:38:35.818', 771.798, 'success', 1, 'a8d6517382cf', 'airflow', 5062, NULL, 'default', 1, 'SSHOperator', '2018-11-12 04:24:18.761', 16751, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_loggedin_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:09:54.475', '2018-11-13 04:26:35.643', 1001.17, 'success', 1, 'a8d6517382cf', 'airflow', 5967, NULL, 'default', 1, 'SSHOperator', '2018-11-13 04:08:36.798', 30428, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:16:20.147', '2018-11-07 11:16:29.831', 9.68406, 'success', 1, 'ca61a2f4ab13', 'airflow', 163, NULL, 'default', 6, 'SSHOperator', '2018-11-07 11:16:18.035', 617, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:54:40.189', '2018-11-08 03:54:50.227', 10.0381, 'success', 1, '6a0f258e32e2', 'airflow', 399, NULL, 'default', 6, 'SSHOperator', '2018-11-08 03:54:37.802', 803, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:54:40.860', '2018-11-09 03:54:51.444', 10.584, 'success', 1, '6a0f258e32e2', 'airflow', 1684, NULL, 'default', 6, 'SSHOperator', '2018-11-09 03:54:38.862', 1584, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:16.990', '2018-11-10 03:41:28.027', 11.0368, 'success', 1, 'a8d6517382cf', 'airflow', 3216, NULL, 'default', 6, 'SSHOperator', '2018-11-10 03:41:14.162', 21811, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:35.517', '2018-11-11 05:11:47.431', 11.9145, 'success', 1, 'a8d6517382cf', 'airflow', 4188, NULL, 'default', 6, 'SSHOperator', '2018-11-11 05:11:33.461', 3579, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:01.029', '2018-11-12 04:51:13.385', 12.356, 'success', 1, 'a8d6517382cf', 'airflow', 5099, NULL, 'default', 6, 'SSHOperator', '2018-11-12 04:50:58.552', 17182, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:21.521', '2018-11-13 04:41:35.282', 13.7605, 'success', 1, 'a8d6517382cf', 'airflow', 5998, NULL, 'default', 6, 'SSHOperator', '2018-11-13 04:41:19.266', 30830, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:21:21.291', '2018-11-07 11:55:15.725', 2034.43, 'success', 1, 'ca61a2f4ab13', 'airflow', 168, NULL, 'default', 5, 'SSHOperator', '2018-11-07 11:21:19.361', 692, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:55:01.473', '2018-11-08 04:40:17.560', 2716.09, 'success', 1, '6a0f258e32e2', 'airflow', 405, NULL, 'default', 5, 'SSHOperator', '2018-11-08 03:54:58.996', 878, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:55:02.295', '2018-11-09 04:03:36.248', 513.953, 'success', 1, '6a0f258e32e2', 'airflow', 1689, NULL, 'default', 5, 'SSHOperator', '2018-11-09 03:55:00.352', 1659, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:38.506', '2018-11-10 03:51:40.425', 601.919, 'success', 1, 'a8d6517382cf', 'airflow', 3223, NULL, 'default', 5, 'SSHOperator', '2018-11-10 03:41:35.499', 21886, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:57.161', '2018-11-11 05:24:00.481', 723.32, 'success', 1, 'a8d6517382cf', 'airflow', 4194, NULL, 'default', 5, 'SSHOperator', '2018-11-11 05:11:54.825', 3654, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:23.140', '2018-11-12 05:08:43.500', 1040.36, 'success', 1, 'a8d6517382cf', 'airflow', 5102, NULL, 'default', 5, 'SSHOperator', '2018-11-12 04:51:20.797', 17257, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:42.871', '2018-11-13 04:56:40.551', 897.68, 'success', 1, 'a8d6517382cf', 'airflow', 6002, NULL, 'default', 5, 'SSHOperator', '2018-11-13 04:41:40.796', 30905, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:17:36.651', '2018-11-07 12:35:00.491', 1043.84, 'success', 1, 'ca61a2f4ab13', 'airflow', 198, NULL, 'default', 3, 'SSHOperator', '2018-11-07 12:17:34.904', 1187, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 05:10:18.568', '2018-11-08 05:28:56.591', 1118.02, 'success', 1, '6a0f258e32e2', 'airflow', 432, NULL, 'default', 3, 'SSHOperator', '2018-11-08 05:10:16.759', 1202, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:23:10.708', '2018-11-09 04:42:43.766', 1173.06, 'success', 1, '6a0f258e32e2', 'airflow', 1724, NULL, 'default', 3, 'SSHOperator', '2018-11-09 04:23:09.254', 2113, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 04:13:18.703', '2018-11-10 04:30:40.797', 1042.09, 'success', 1, 'a8d6517382cf', 'airflow', 3256, NULL, 'default', 3, 'SSHOperator', '2018-11-10 04:13:16.994', 22385, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:41:20.564', '2018-11-11 05:48:10.158', 409.594, 'success', 1, 'a8d6517382cf', 'airflow', 4231, NULL, 'default', 3, 'SSHOperator', '2018-11-11 05:41:18.981', 4191, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:28:28.746', '2018-11-12 05:50:31.040', 1322.29, 'success', 1, 'a8d6517382cf', 'airflow', 5144, NULL, 'default', 3, 'SSHOperator', '2018-11-12 05:28:27.105', 17839, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 05:21:34.826', '2018-11-13 05:48:27.259', 1612.43, 'success', 1, 'a8d6517382cf', 'airflow', 6048, NULL, 'default', 3, 'SSHOperator', '2018-11-13 05:21:33.369', 31515, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:37:56.627', '2018-11-07 12:45:01.322', 424.695, 'success', 1, 'ca61a2f4ab13', 'airflow', 211, NULL, 'default', 2, 'SSHOperator', '2018-11-07 12:37:55.111', 1410, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 05:29:04.523', '2018-11-08 05:31:14.016', 129.494, 'success', 1, '6a0f258e32e2', 'airflow', 448, NULL, 'default', 2, 'SSHOperator', '2018-11-08 05:29:03.107', 1408, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:42:51.085', '2018-11-09 04:45:41.486', 170.401, 'success', 1, '6a0f258e32e2', 'airflow', 1732, NULL, 'default', 2, 'SSHOperator', '2018-11-09 04:42:49.377', 2199, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 04:30:46.704', '2018-11-10 04:34:49.509', 242.806, 'success', 1, 'a8d6517382cf', 'airflow', 3267, NULL, 'default', 2, 'SSHOperator', '2018-11-10 04:30:45.215', 22523, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:48:22.669', '2018-11-11 05:50:13.333', 110.664, 'success', 1, 'a8d6517382cf', 'airflow', 4242, NULL, 'default', 2, 'SSHOperator', '2018-11-11 05:48:21.265', 4335, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:50:37.488', '2018-11-12 05:54:05.595', 208.107, 'success', 1, 'a8d6517382cf', 'airflow', 5156, NULL, 'default', 2, 'SSHOperator', '2018-11-12 05:50:35.888', 17981, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 05:48:29.137', '2018-11-13 06:07:01.746', 1112.61, 'success', 1, 'a8d6517382cf', 'airflow', 6062, NULL, 'default', 2, 'SSHOperator', '2018-11-13 05:48:27.749', 31670, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:48:10.114', '2018-11-07 12:48:20.728', 10.6139, 'success', 1, 'ca61a2f4ab13', 'airflow', 215, NULL, 'default', 1, 'SSHOperator', '2018-11-07 12:48:08.661', 1472, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 05:31:21.751', '2018-11-08 05:31:32.087', 10.3359, 'success', 1, '6a0f258e32e2', 'airflow', 449, NULL, 'default', 1, 'SSHOperator', '2018-11-08 05:31:20.118', 1423, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:45:49.551', '2018-11-09 04:46:00.308', 10.7573, 'success', 1, '6a0f258e32e2', 'airflow', 1736, NULL, 'default', 1, 'SSHOperator', '2018-11-09 04:45:48.071', 2255, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 04:34:59.319', '2018-11-10 04:35:09.629', 10.3105, 'success', 1, 'a8d6517382cf', 'airflow', 3268, NULL, 'default', 1, 'SSHOperator', '2018-11-10 04:34:57.886', 22538, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:50:19.561', '2018-11-11 05:50:30.518', 10.9571, 'success', 1, 'a8d6517382cf', 'airflow', 4243, NULL, 'default', 1, 'SSHOperator', '2018-11-11 05:50:17.931', 4350, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:54:08.454', '2018-11-12 05:54:19.519', 11.0649, 'success', 1, 'a8d6517382cf', 'airflow', 5157, NULL, 'default', 1, 'SSHOperator', '2018-11-12 05:54:07.002', 17996, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 06:07:20.102', '2018-11-13 06:07:31.873', 11.7708, 'success', 1, 'a8d6517382cf', 'airflow', 6070, NULL, 'default', 1, 'SSHOperator', '2018-11-13 06:07:18.527', 31756, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:57:07.587', '2018-11-07 12:15:12.247', 1084.66, 'success', 1, 'ca61a2f4ab13', 'airflow', 182, NULL, 'default', 4, 'SSHOperator', '2018-11-07 11:57:05.306', 902, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:40:24.365', '2018-11-08 05:10:08.447', 1784.08, 'success', 1, '6a0f258e32e2', 'airflow', 421, NULL, 'default', 4, 'SSHOperator', '2018-11-08 04:40:23.011', 1082, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:03:38.494', '2018-11-09 04:23:06.263', 1167.77, 'success', 1, '6a0f258e32e2', 'airflow', 1697, NULL, 'default', 4, 'SSHOperator', '2018-11-09 04:03:36.904', 1758, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:51:44.628', '2018-11-10 04:13:07.155', 1282.53, 'success', 1, 'a8d6517382cf', 'airflow', 3234, NULL, 'default', 4, 'SSHOperator', '2018-11-10 03:51:42.778', 22069, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:24:09.728', '2018-11-11 05:41:13.185', 1023.46, 'success', 1, 'a8d6517382cf', 'airflow', 4217, NULL, 'default', 4, 'SSHOperator', '2018-11-11 05:24:06.138', 4015, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:08:53.243', '2018-11-12 05:28:24.173', 1170.93, 'success', 1, 'a8d6517382cf', 'airflow', 5122, NULL, 'default', 4, 'SSHOperator', '2018-11-12 05:08:51.626', 17549, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_article_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:56:46.326', '2018-11-13 05:21:24.141', 1477.82, 'success', 1, 'a8d6517382cf', 'airflow', 6024, NULL, 'default', 4, 'SSHOperator', '2018-11-13 04:56:44.861', 31195, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:16:19.905', '2018-11-07 11:16:29.892', 9.98658, 'success', 1, 'ca61a2f4ab13', 'airflow', 162, NULL, 'default', 6, 'SSHOperator', '2018-11-07 11:16:18.035', 619, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:54:40.227', '2018-11-08 03:54:50.019', 9.79259, 'success', 1, '6a0f258e32e2', 'airflow', 401, NULL, 'default', 6, 'SSHOperator', '2018-11-08 03:54:37.802', 807, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:54:40.858', '2018-11-09 03:54:51.830', 10.9717, 'success', 1, '6a0f258e32e2', 'airflow', 1686, NULL, 'default', 6, 'SSHOperator', '2018-11-09 03:54:38.862', 1586, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:17.234', '2018-11-10 03:41:28.067', 10.8336, 'success', 1, 'a8d6517382cf', 'airflow', 3218, NULL, 'default', 6, 'SSHOperator', '2018-11-10 03:41:14.162', 21815, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:35.538', '2018-11-11 05:11:47.297', 11.7597, 'success', 1, 'a8d6517382cf', 'airflow', 4189, NULL, 'default', 6, 'SSHOperator', '2018-11-11 05:11:33.461', 3581, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:00.933', '2018-11-12 04:51:13.519', 12.5854, 'success', 1, 'a8d6517382cf', 'airflow', 5098, NULL, 'default', 6, 'SSHOperator', '2018-11-12 04:50:58.552', 17184, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:21.634', '2018-11-13 04:41:35.244', 13.61, 'success', 1, 'a8d6517382cf', 'airflow', 6000, NULL, 'default', 6, 'SSHOperator', '2018-11-13 04:41:19.266', 30832, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:21:21.567', '2018-11-07 11:56:07.726', 2086.16, 'success', 1, 'ca61a2f4ab13', 'airflow', 170, NULL, 'default', 5, 'SSHOperator', '2018-11-07 11:21:19.361', 694, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:55:01.025', '2018-11-08 04:37:42.179', 2561.15, 'success', 1, '6a0f258e32e2', 'airflow', 403, NULL, 'default', 5, 'SSHOperator', '2018-11-08 03:54:58.996', 880, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:55:02.598', '2018-11-09 04:03:51.641', 529.043, 'success', 1, '6a0f258e32e2', 'airflow', 1690, NULL, 'default', 5, 'SSHOperator', '2018-11-09 03:55:00.352', 1661, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:38.127', '2018-11-10 03:51:35.647', 597.521, 'success', 1, 'a8d6517382cf', 'airflow', 3221, NULL, 'default', 5, 'SSHOperator', '2018-11-10 03:41:35.499', 21890, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:56.772', '2018-11-11 05:23:00.830', 664.058, 'success', 1, 'a8d6517382cf', 'airflow', 4192, NULL, 'default', 5, 'SSHOperator', '2018-11-11 05:11:54.825', 3656, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:23.184', '2018-11-12 05:04:22.769', 779.585, 'success', 1, 'a8d6517382cf', 'airflow', 5104, NULL, 'default', 5, 'SSHOperator', '2018-11-12 04:51:20.797', 17259, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:43.049', '2018-11-13 04:54:43.644', 780.596, 'success', 1, 'a8d6517382cf', 'airflow', 6004, NULL, 'default', 5, 'SSHOperator', '2018-11-13 04:41:40.796', 30907, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:17:36.588', '2018-11-07 12:29:48.187', 731.598, 'success', 1, 'ca61a2f4ab13', 'airflow', 197, NULL, 'default', 1, 'SSHOperator', '2018-11-07 12:17:34.904', 1193, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 05:10:18.563', '2018-11-08 05:28:31.217', 1092.65, 'success', 1, '6a0f258e32e2', 'airflow', 433, NULL, 'default', 1, 'SSHOperator', '2018-11-08 05:10:16.759', 1204, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:23:53.176', '2018-11-09 04:45:36.470', 1303.29, 'success', 1, '6a0f258e32e2', 'airflow', 1725, NULL, 'default', 1, 'SSHOperator', '2018-11-09 04:23:51.542', 2128, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 04:14:32.414', '2018-11-10 04:36:11.424', 1299.01, 'success', 1, 'a8d6517382cf', 'airflow', 3257, NULL, 'default', 1, 'SSHOperator', '2018-11-10 04:14:30.986', 22400, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:39:24.245', '2018-11-11 05:50:12.681', 648.436, 'success', 1, 'a8d6517382cf', 'airflow', 4229, NULL, 'default', 1, 'SSHOperator', '2018-11-11 05:39:22.808', 4163, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:15:14.543', '2018-11-12 05:55:05.495', 2390.95, 'success', 1, 'a8d6517382cf', 'airflow', 5125, NULL, 'default', 1, 'SSHOperator', '2018-11-12 05:15:12.885', 17592, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 05:09:02.461', '2018-11-13 05:37:35.676', 1713.22, 'success', 1, 'a8d6517382cf', 'airflow', 6030, NULL, 'default', 1, 'SSHOperator', '2018-11-13 05:09:00.663', 31268, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:57:07.719', '2018-11-07 12:15:49.814', 1122.09, 'success', 1, 'ca61a2f4ab13', 'airflow', 185, NULL, 'default', 2, 'SSHOperator', '2018-11-07 11:57:05.306', 908, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:37:45.913', '2018-11-08 05:10:11.479', 1945.57, 'success', 1, '6a0f258e32e2', 'airflow', 417, NULL, 'default', 2, 'SSHOperator', '2018-11-08 04:37:44.460', 1009, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:04:00.307', '2018-11-09 04:23:42.552', 1182.24, 'success', 1, '6a0f258e32e2', 'airflow', 1700, NULL, 'default', 2, 'SSHOperator', '2018-11-09 04:03:58.243', 1777, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:51:44.491', '2018-11-10 04:14:29.124', 1364.63, 'success', 1, 'a8d6517382cf', 'airflow', 3232, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:51:42.778', 22073, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:23:03.648', '2018-11-11 05:39:20.341', 976.693, 'success', 1, 'a8d6517382cf', 'airflow', 4214, NULL, 'default', 2, 'SSHOperator', '2018-11-11 05:23:01.695', 3957, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:04:33.464', '2018-11-12 05:15:08.218', 634.753, 'success', 1, 'a8d6517382cf', 'airflow', 5113, NULL, 'default', 2, 'SSHOperator', '2018-11-12 05:04:31.660', 17416, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_beacon_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:54:52.597', '2018-11-13 05:08:57.093', 844.496, 'success', 1, 'a8d6517382cf', 'airflow', 6019, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:54:50.819', 31122, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:16:20.315', '2018-11-07 11:16:30.618', 10.3035, 'success', 1, 'ca61a2f4ab13', 'airflow', 165, NULL, 'default', 7, 'SSHOperator', '2018-11-07 11:16:18.035', 613, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:54:40.192', '2018-11-08 03:54:49.785', 9.59316, 'success', 1, '6a0f258e32e2', 'airflow', 400, NULL, 'default', 7, 'SSHOperator', '2018-11-08 03:54:37.802', 799, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:54:41.142', '2018-11-09 03:54:52.327', 11.1856, 'success', 1, '6a0f258e32e2', 'airflow', 1687, NULL, 'default', 7, 'SSHOperator', '2018-11-09 03:54:38.862', 1580, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:16.813', '2018-11-10 03:41:27.224', 10.4118, 'success', 1, 'a8d6517382cf', 'airflow', 3214, NULL, 'default', 7, 'SSHOperator', '2018-11-10 03:41:14.162', 21807, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:35.435', '2018-11-11 05:11:47.089', 11.6536, 'success', 1, 'a8d6517382cf', 'airflow', 4186, NULL, 'default', 7, 'SSHOperator', '2018-11-11 05:11:33.461', 3575, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:00.567', '2018-11-12 04:51:12.342', 11.775, 'success', 1, 'a8d6517382cf', 'airflow', 5095, NULL, 'default', 7, 'SSHOperator', '2018-11-12 04:50:58.552', 17178, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:21.694', '2018-11-13 04:41:35.195', 13.5011, 'success', 1, 'a8d6517382cf', 'airflow', 6001, NULL, 'default', 7, 'SSHOperator', '2018-11-13 04:41:19.266', 30826, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:21:21.481', '2018-11-07 11:55:59.264', 2077.78, 'success', 1, 'ca61a2f4ab13', 'airflow', 169, NULL, 'default', 6, 'SSHOperator', '2018-11-07 11:21:19.361', 688, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:55:01.049', '2018-11-08 04:37:20.059', 2539.01, 'success', 1, '6a0f258e32e2', 'airflow', 404, NULL, 'default', 6, 'SSHOperator', '2018-11-08 03:54:58.996', 874, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:55:02.688', '2018-11-09 04:05:34.168', 631.48, 'success', 1, '6a0f258e32e2', 'airflow', 1691, NULL, 'default', 6, 'SSHOperator', '2018-11-09 03:55:00.352', 1655, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:38.279', '2018-11-10 03:51:27.613', 589.334, 'success', 1, 'a8d6517382cf', 'airflow', 3222, NULL, 'default', 6, 'SSHOperator', '2018-11-10 03:41:35.499', 21882, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:56.633', '2018-11-11 05:27:13.903', 917.27, 'success', 1, 'a8d6517382cf', 'airflow', 4191, NULL, 'default', 6, 'SSHOperator', '2018-11-11 05:11:54.825', 3650, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:23.176', '2018-11-12 05:04:13.274', 770.098, 'success', 1, 'a8d6517382cf', 'airflow', 5103, NULL, 'default', 6, 'SSHOperator', '2018-11-12 04:51:20.797', 17253, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:43.111', '2018-11-13 04:53:42.533', 719.422, 'success', 1, 'a8d6517382cf', 'airflow', 6006, NULL, 'default', 6, 'SSHOperator', '2018-11-13 04:41:40.796', 30901, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:27:42.375', '2018-11-07 12:47:01.740', 1159.36, 'success', 1, 'ca61a2f4ab13', 'airflow', 204, NULL, 'default', 1, 'SSHOperator', '2018-11-07 12:27:40.893', 1291, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 05:09:14.794', '2018-11-08 05:27:00.870', 1066.08, 'success', 1, '6a0f258e32e2', 'airflow', 431, NULL, 'default', 1, 'SSHOperator', '2018-11-08 05:09:13.363', 1187, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:25:17.640', '2018-11-09 04:36:27.731', 670.091, 'success', 1, '6a0f258e32e2', 'airflow', 1726, NULL, 'default', 1, 'SSHOperator', '2018-11-09 04:25:16.149', 2143, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 04:12:36.518', '2018-11-10 04:25:14.827', 758.31, 'success', 1, 'a8d6517382cf', 'airflow', 3255, NULL, 'default', 1, 'SSHOperator', '2018-11-10 04:12:34.875', 22370, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:43:17.132', '2018-11-11 05:48:19.896', 302.764, 'success', 1, 'a8d6517382cf', 'airflow', 4232, NULL, 'default', 1, 'SSHOperator', '2018-11-11 05:43:15.713', 4206, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:17:10.652', '2018-11-12 05:42:18.908', 1508.26, 'success', 1, 'a8d6517382cf', 'airflow', 5127, NULL, 'default', 1, 'SSHOperator', '2018-11-12 05:17:08.854', 17607, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 05:10:26.922', '2018-11-13 05:33:55.473', 1408.55, 'success', 1, 'a8d6517382cf', 'airflow', 6031, NULL, 'default', 1, 'SSHOperator', '2018-11-13 05:10:25.368', 31283, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_refresh_partitions_in_qubole', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:57:07.570', '2018-11-07 11:58:53.168', 105.598, 'success', 1, 'ca61a2f4ab13', 'airflow', 181, NULL, 'default', 3, 'QuboleOperator', '2018-11-07 11:57:05.306', 904, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_refresh_partitions_in_qubole', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:37:24.792', '2018-11-08 04:39:19.708', 114.917, 'success', 1, '6a0f258e32e2', 'airflow', 414, NULL, 'default', 3, 'QuboleOperator', '2018-11-08 04:37:23.313', 979, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_refresh_partitions_in_qubole', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:05:46.298', '2018-11-09 04:07:51.745', 125.447, 'success', 1, '6a0f258e32e2', 'airflow', 1706, NULL, 'default', 3, 'QuboleOperator', '2018-11-09 04:05:44.568', 1889, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_refresh_partitions_in_qubole', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:51:33.913', '2018-11-10 03:53:23.470', 109.558, 'success', 1, 'a8d6517382cf', 'airflow', 3231, NULL, 'default', 3, 'QuboleOperator', '2018-11-10 03:51:32.178', 22041, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_refresh_partitions_in_qubole', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:27:19.407', '2018-11-11 05:29:14.139', 114.732, 'success', 1, 'a8d6517382cf', 'airflow', 4219, NULL, 'default', 3, 'QuboleOperator', '2018-11-11 05:27:18.006', 4045, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_refresh_partitions_in_qubole', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:04:22.267', '2018-11-12 05:06:32.025', 129.758, 'success', 1, 'a8d6517382cf', 'airflow', 5110, NULL, 'default', 3, 'QuboleOperator', '2018-11-12 05:04:20.743', 17386, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_refresh_partitions_in_qubole', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:53:48.360', '2018-11-13 04:55:53.966', 125.606, 'success', 1, 'a8d6517382cf', 'airflow', 6016, NULL, 'default', 3, 'QuboleOperator', '2018-11-13 04:53:46.774', 31092, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:17:36.711', '2018-11-07 12:27:40.718', 604.007, 'success', 2, 'ca61a2f4ab13', 'airflow', 199, NULL, 'default', 2, 'SSHOperator', '2018-11-07 11:57:05.306', 1192, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:37:24.815', '2018-11-08 05:09:03.888', 1899.07, 'success', 1, '6a0f258e32e2', 'airflow', 415, NULL, 'default', 2, 'SSHOperator', '2018-11-08 04:37:23.313', 981, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:05:46.320', '2018-11-09 04:25:07.538', 1161.22, 'success', 1, '6a0f258e32e2', 'airflow', 1707, NULL, 'default', 2, 'SSHOperator', '2018-11-09 04:05:44.568', 1891, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:51:33.800', '2018-11-10 04:12:28.646', 1254.85, 'success', 1, 'a8d6517382cf', 'airflow', 3230, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:51:32.178', 22043, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:27:19.434', '2018-11-11 05:43:14.150', 954.716, 'success', 1, 'a8d6517382cf', 'airflow', 4220, NULL, 'default', 2, 'SSHOperator', '2018-11-11 05:27:18.006', 4047, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:04:22.339', '2018-11-12 05:17:04.037', 761.698, 'success', 1, 'a8d6517382cf', 'airflow', 5111, NULL, 'default', 2, 'SSHOperator', '2018-11-12 05:04:20.743', 17388, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_geo_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:53:48.571', '2018-11-13 05:10:19.226', 990.655, 'success', 1, 'a8d6517382cf', 'airflow', 6017, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:53:46.774', 31094, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:16:19.872', '2018-11-07 11:16:29.737', 9.86481, 'success', 1, 'ca61a2f4ab13', 'airflow', 161, NULL, 'default', 7, 'SSHOperator', '2018-11-07 11:16:18.035', 615, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:54:40.178', '2018-11-08 03:54:50.139', 9.96065, 'success', 1, '6a0f258e32e2', 'airflow', 398, NULL, 'default', 7, 'SSHOperator', '2018-11-08 03:54:37.802', 801, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:54:41.174', '2018-11-09 03:54:51.596', 10.4216, 'success', 1, '6a0f258e32e2', 'airflow', 1688, NULL, 'default', 7, 'SSHOperator', '2018-11-09 03:54:38.862', 1582, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:17.060', '2018-11-10 03:41:27.925', 10.8658, 'success', 1, 'a8d6517382cf', 'airflow', 3217, NULL, 'default', 7, 'SSHOperator', '2018-11-10 03:41:14.162', 21809, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:35.552', '2018-11-11 05:11:47.284', 11.7322, 'success', 1, 'a8d6517382cf', 'airflow', 4190, NULL, 'default', 7, 'SSHOperator', '2018-11-11 05:11:33.461', 3577, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:00.817', '2018-11-12 04:51:12.945', 12.1283, 'success', 1, 'a8d6517382cf', 'airflow', 5096, NULL, 'default', 7, 'SSHOperator', '2018-11-12 04:50:58.552', 17180, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:21.240', '2018-11-13 04:41:34.349', 13.1093, 'success', 1, 'a8d6517382cf', 'airflow', 5997, NULL, 'default', 7, 'SSHOperator', '2018-11-13 04:41:19.266', 30828, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:21:21.281', '2018-11-07 11:53:11.037', 1909.76, 'success', 1, 'ca61a2f4ab13', 'airflow', 167, NULL, 'default', 6, 'SSHOperator', '2018-11-07 11:21:19.361', 690, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:55:01.470', '2018-11-08 04:33:25.391', 2303.92, 'success', 1, '6a0f258e32e2', 'airflow', 407, NULL, 'default', 6, 'SSHOperator', '2018-11-08 03:54:58.996', 876, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:55:02.705', '2018-11-09 03:58:56.955', 234.249, 'success', 1, '6a0f258e32e2', 'airflow', 1692, NULL, 'default', 6, 'SSHOperator', '2018-11-09 03:55:00.352', 1657, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:38.066', '2018-11-10 03:48:13.591', 395.525, 'success', 1, 'a8d6517382cf', 'airflow', 3220, NULL, 'default', 6, 'SSHOperator', '2018-11-10 03:41:35.499', 21884, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:56.858', '2018-11-11 05:21:57.300', 600.442, 'success', 1, 'a8d6517382cf', 'airflow', 4193, NULL, 'default', 6, 'SSHOperator', '2018-11-11 05:11:54.825', 3652, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:23.122', '2018-11-12 04:53:59.808', 156.686, 'success', 1, 'a8d6517382cf', 'airflow', 5100, NULL, 'default', 6, 'SSHOperator', '2018-11-12 04:51:20.797', 17255, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:43.096', '2018-11-13 04:46:55.995', 312.9, 'success', 1, 'a8d6517382cf', 'airflow', 6005, NULL, 'default', 6, 'SSHOperator', '2018-11-13 04:41:40.796', 30903, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_mark_success', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:17:37.068', '2018-11-07 12:17:51.231', 14.163, 'success', 1, 'ca61a2f4ab13', 'airflow', 200, NULL, 'default', 3, 'SSHOperator', '2018-11-07 12:17:34.904', 1189, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_mark_success', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:54:35.796', '2018-11-08 04:54:46.136', 10.3395, 'success', 1, '6a0f258e32e2', 'airflow', 427, NULL, 'default', 3, 'SSHOperator', '2018-11-08 04:54:34.348', 1142, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_mark_success', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:09:40.183', '2018-11-09 04:09:52.981', 12.7974, 'success', 1, '6a0f258e32e2', 'airflow', 1715, NULL, 'default', 3, 'SSHOperator', '2018-11-09 04:09:38.663', 2014, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_mark_success', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:59:04.970', '2018-11-10 03:59:15.991', 11.0206, 'success', 1, 'a8d6517382cf', 'airflow', 3240, NULL, 'default', 3, 'SSHOperator', '2018-11-10 03:59:03.480', 22174, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_mark_success', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:33:43.300', '2018-11-11 05:33:53.695', 10.3951, 'success', 1, 'a8d6517382cf', 'airflow', 4224, NULL, 'default', 3, 'SSHOperator', '2018-11-11 05:33:41.830', 4103, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_mark_success', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:06:47.487', '2018-11-12 05:06:59.738', 12.2506, 'success', 1, 'a8d6517382cf', 'airflow', 5120, NULL, 'default', 3, 'SSHOperator', '2018-11-12 05:06:45.406', 17504, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_mark_success', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:53:06.048', '2018-11-13 04:53:18.203', 12.1544, 'success', 1, 'a8d6517382cf', 'airflow', 6014, NULL, 'default', 3, 'SSHOperator', '2018-11-13 04:53:04.260', 31062, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:07:20.861', '2018-11-07 12:16:16.031', 535.17, 'success', 1, 'ca61a2f4ab13', 'airflow', 191, NULL, 'default', 4, 'SSHOperator', '2018-11-07 12:07:19.209', 1074, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:43:11.363', '2018-11-08 04:54:29.861', 678.498, 'success', 1, '6a0f258e32e2', 'airflow', 423, NULL, 'default', 4, 'SSHOperator', '2018-11-08 04:43:09.953', 1097, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:04:00.118', '2018-11-09 04:09:34.804', 334.686, 'success', 1, '6a0f258e32e2', 'airflow', 1699, NULL, 'default', 4, 'SSHOperator', '2018-11-09 04:03:58.243', 1773, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:52:05.496', '2018-11-10 03:58:56.179', 410.684, 'success', 1, 'a8d6517382cf', 'airflow', 3236, NULL, 'default', 4, 'SSHOperator', '2018-11-10 03:52:04.099', 22129, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:26:58.166', '2018-11-11 05:33:36.282', 398.116, 'success', 1, 'a8d6517382cf', 'airflow', 4218, NULL, 'default', 4, 'SSHOperator', '2018-11-11 05:26:56.765', 4030, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:03:50.124', '2018-11-12 05:06:44.095', 173.971, 'success', 1, 'a8d6517382cf', 'airflow', 5109, NULL, 'default', 4, 'SSHOperator', '2018-11-12 05:03:48.588', 17371, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:51:18.771', '2018-11-13 04:52:55.226', 96.4549, 'success', 1, 'a8d6517382cf', 'airflow', 6013, NULL, 'default', 4, 'SSHOperator', '2018-11-13 04:51:17.403', 31047, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:22:37.436', '2018-11-07 12:23:43.198', 65.7624, 'success', 1, 'ca61a2f4ab13', 'airflow', 202, NULL, 'default', 2, 'SSHOperator', '2018-11-07 12:22:35.939', 1274, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:54:56.680', '2018-11-08 05:07:55.949', 779.268, 'success', 1, '6a0f258e32e2', 'airflow', 428, NULL, 'default', 2, 'SSHOperator', '2018-11-08 04:54:55.327', 1157, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:10:01.770', '2018-11-09 04:16:25.937', 384.167, 'success', 1, '6a0f258e32e2', 'airflow', 1716, NULL, 'default', 2, 'SSHOperator', '2018-11-09 04:10:00.313', 2029, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:59:26.160', '2018-11-10 04:06:20.484', 414.324, 'success', 1, 'a8d6517382cf', 'airflow', 3241, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:59:24.597', 22189, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:34:04.649', '2018-11-11 05:34:51.001', 46.3513, 'success', 1, 'a8d6517382cf', 'airflow', 4225, NULL, 'default', 2, 'SSHOperator', '2018-11-11 05:34:02.995', 4118, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:07:08.326', '2018-11-12 05:21:06.223', 837.897, 'success', 1, 'a8d6517382cf', 'airflow', 5121, NULL, 'default', 2, 'SSHOperator', '2018-11-12 05:07:06.566', 17534, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:53:27.032', '2018-11-13 04:55:10.717', 103.684, 'success', 1, 'a8d6517382cf', 'airflow', 6015, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:53:25.484', 31077, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 12:27:42.473', '2018-11-07 12:27:57.943', 15.4701, 'success', 1, 'ca61a2f4ab13', 'airflow', 205, NULL, 'default', 1, 'SSHOperator', '2018-11-07 12:27:40.893', 1293, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 05:08:01.284', '2018-11-08 05:08:11.352', 10.0676, 'success', 1, '6a0f258e32e2', 'airflow', 430, NULL, 'default', 1, 'SSHOperator', '2018-11-08 05:07:59.738', 1172, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:16:28.406', '2018-11-09 04:16:38.888', 10.4825, 'success', 1, '6a0f258e32e2', 'airflow', 1719, NULL, 'default', 1, 'SSHOperator', '2018-11-09 04:16:27.046', 2059, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 04:06:29.390', '2018-11-10 04:06:40.042', 10.6527, 'success', 1, 'a8d6517382cf', 'airflow', 3251, NULL, 'default', 1, 'SSHOperator', '2018-11-10 04:06:27.878', 22329, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:34:57.002', '2018-11-11 05:35:07.185', 10.1829, 'success', 1, 'a8d6517382cf', 'airflow', 4226, NULL, 'default', 1, 'SSHOperator', '2018-11-11 05:34:55.499', 4133, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 05:21:12.954', '2018-11-12 05:21:25.635', 12.6816, 'success', 1, 'a8d6517382cf', 'airflow', 5136, NULL, 'default', 1, 'SSHOperator', '2018-11-12 05:21:11.457', 17738, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_move_to_mysql_mark_success', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:55:13.847', '2018-11-13 04:55:25.898', 12.0516, 'success', 1, 'a8d6517382cf', 'airflow', 6021, NULL, 'default', 1, 'SSHOperator', '2018-11-13 04:55:12.194', 31165, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:57:07.592', '2018-11-07 12:05:01.466', 473.874, 'success', 1, 'ca61a2f4ab13', 'airflow', 183, NULL, 'default', 5, 'SSHOperator', '2018-11-07 11:57:05.306', 900, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:33:30.839', '2018-11-08 04:43:09.780', 578.941, 'success', 1, '6a0f258e32e2', 'airflow', 413, NULL, 'default', 5, 'SSHOperator', '2018-11-08 04:33:29.453', 964, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:59:07.263', '2018-11-09 04:03:49.364', 282.101, 'success', 1, '6a0f258e32e2', 'airflow', 1694, NULL, 'default', 5, 'SSHOperator', '2018-11-09 03:59:05.577', 1730, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:48:23.505', '2018-11-10 03:51:52.682', 209.177, 'success', 1, 'a8d6517382cf', 'airflow', 3229, NULL, 'default', 5, 'SSHOperator', '2018-11-10 03:48:21.495', 22026, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:22:09.146', '2018-11-11 05:26:52.537', 283.391, 'success', 1, 'a8d6517382cf', 'airflow', 4211, NULL, 'default', 5, 'SSHOperator', '2018-11-11 05:22:07.770', 3927, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:54:02.455', '2018-11-12 05:03:42.713', 580.258, 'success', 1, 'a8d6517382cf', 'airflow', 5105, NULL, 'default', 5, 'SSHOperator', '2018-11-12 04:54:00.860', 17328, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_pageviews_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:47:04.984', '2018-11-13 04:51:08.372', 243.388, 'success', 1, 'a8d6517382cf', 'airflow', 6012, NULL, 'default', 5, 'SSHOperator', '2018-11-13 04:47:03.501', 31032, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:08:39.531', '2018-11-07 09:08:45.737', 6.20648, 'success', 1, 'ca61a2f4ab13', 'airflow', 135, NULL, 'default', 3, 'SSHOperator', '2018-11-07 09:08:38.140', 418, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:14:55.270', '2018-11-08 03:15:02.184', 6.91463, 'success', 1, '6a0f258e32e2', 'airflow', 384, NULL, 'default', 3, 'SSHOperator', '2018-11-08 03:14:53.447', 649, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:13:31.481', '2018-11-09 03:13:40.159', 8.67778, 'success', 1, '6a0f258e32e2', 'airflow', 1626, NULL, 'default', 3, 'SSHOperator', '2018-11-09 03:13:29.965', 858, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:58:44.783', '2018-11-10 02:58:51.288', 6.50552, 'success', 1, 'a8d6517382cf', 'airflow', 3150, NULL, 'default', 3, 'SSHOperator', '2018-11-10 02:58:43.172', 20962, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 03:57:53.113', '2018-11-11 03:58:02.172', 9.05886, 'success', 1, 'a8d6517382cf', 'airflow', 4078, NULL, 'default', 3, 'SSHOperator', '2018-11-11 03:27:03.341', 2288, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:46:34.063', '2018-11-12 03:46:43.839', 9.77661, 'success', 1, 'a8d6517382cf', 'airflow', 5017, NULL, 'default', 3, 'SSHOperator', '2018-11-12 03:45:37.429', 16192, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 03:42:41.137', '2018-11-13 03:42:48.392', 7.25513, 'success', 1, 'a8d6517382cf', 'airflow', 5920, NULL, 'default', 3, 'SSHOperator', '2018-11-13 03:41:46.258', 29825, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:13:53.307', '2018-11-07 09:38:26.522', 1473.21, 'success', 1, 'ca61a2f4ab13', 'airflow', 137, NULL, 'default', 2, 'SSHOperator', '2018-11-07 09:13:51.851', 433, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:15:05.846', '2018-11-08 03:24:40.443', 574.597, 'success', 1, '6a0f258e32e2', 'airflow', 385, NULL, 'default', 2, 'SSHOperator', '2018-11-08 03:15:04.242', 664, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:13:42.439', '2018-11-09 03:33:00.104', 1157.67, 'success', 1, '6a0f258e32e2', 'airflow', 1627, NULL, 'default', 2, 'SSHOperator', '2018-11-09 03:13:40.711', 873, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:58:55.769', '2018-11-10 03:35:53.591', 2217.82, 'success', 1, 'a8d6517382cf', 'airflow', 3151, NULL, 'default', 2, 'SSHOperator', '2018-11-10 02:58:54.105', 20977, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 03:59:40.425', '2018-11-11 04:15:02.675', 922.25, 'success', 1, 'a8d6517382cf', 'airflow', 4105, NULL, 'default', 2, 'SSHOperator', '2018-11-11 03:58:04.253', 2525, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:47:11.286', '2018-11-12 04:23:50.461', 2199.17, 'success', 1, 'a8d6517382cf', 'airflow', 5023, NULL, 'default', 2, 'SSHOperator', '2018-11-12 03:46:54.741', 16286, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 03:43:29.526', '2018-11-13 04:07:10.010', 1420.48, 'success', 1, 'a8d6517382cf', 'airflow', 5926, NULL, 'default', 2, 'SSHOperator', '2018-11-13 03:42:51.777', 29913, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:39:15.419', '2018-11-07 09:43:55.614', 280.195, 'success', 1, 'ca61a2f4ab13', 'airflow', 140, NULL, 'default', 1, 'SSHOperator', '2018-11-07 09:39:13.769', 448, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:24:52.771', '2018-11-08 03:38:13.789', 801.018, 'success', 1, '6a0f258e32e2', 'airflow', 391, NULL, 'default', 1, 'SSHOperator', '2018-11-08 03:24:51.135', 739, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:33:10.067', '2018-11-09 03:44:07.208', 657.142, 'success', 1, '6a0f258e32e2', 'airflow', 1660, NULL, 'default', 1, 'SSHOperator', '2018-11-09 03:33:08.670', 1282, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:35:58.187', '2018-11-10 03:38:49.672', 171.485, 'success', 1, 'a8d6517382cf', 'airflow', 3202, NULL, 'default', 1, 'SSHOperator', '2018-11-10 03:35:54.383', 21642, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:15:10.017', '2018-11-11 04:38:58.086', 1428.07, 'success', 1, 'a8d6517382cf', 'airflow', 4151, NULL, 'default', 1, 'SSHOperator', '2018-11-11 04:15:08.024', 3149, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:24:22.246', '2018-11-12 04:31:36.052', 433.807, 'success', 1, 'a8d6517382cf', 'airflow', 5058, NULL, 'default', 1, 'SSHOperator', '2018-11-12 04:23:57.400', 16689, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_searches_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:07:41.104', '2018-11-13 04:21:45.873', 844.769, 'success', 1, 'a8d6517382cf', 'airflow', 5961, NULL, 'default', 1, 'SSHOperator', '2018-11-13 04:07:20.388', 30340, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:44:25.293', '2018-11-07 09:44:31.650', 6.3564, 'success', 1, 'ca61a2f4ab13', 'airflow', 142, NULL, 'default', 4, 'SSHOperator', '2018-11-07 09:44:23.820', 463, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:19:31.401', '2018-11-08 03:19:39.933', 8.53169, 'success', 1, '6a0f258e32e2', 'airflow', 386, NULL, 'default', 4, 'SSHOperator', '2018-11-08 03:19:29.916', 679, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:36:21.622', '2018-11-09 03:36:28.382', 6.76015, 'success', 1, '6a0f258e32e2', 'airflow', 1669, NULL, 'default', 4, 'SSHOperator', '2018-11-09 03:36:20.257', 1401, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:08:58.561', '2018-11-10 03:09:05.738', 7.177, 'success', 1, 'a8d6517382cf', 'airflow', 3156, NULL, 'default', 4, 'SSHOperator', '2018-11-10 03:08:56.947', 21035, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:06:37.437', '2018-11-11 04:06:44.430', 6.99302, 'success', 1, 'a8d6517382cf', 'airflow', 4123, NULL, 'default', 4, 'SSHOperator', '2018-11-11 04:02:47.372', 2787, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:23:57.912', '2018-11-12 04:24:04.813', 6.9005, 'success', 1, 'a8d6517382cf', 'airflow', 5055, NULL, 'default', 4, 'SSHOperator', '2018-11-12 04:22:31.347', 16644, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:08:10.679', '2018-11-13 04:08:17.566', 6.88703, 'success', 1, 'a8d6517382cf', 'airflow', 5962, NULL, 'default', 4, 'SSHOperator', '2018-11-13 04:07:31.573', 30355, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 09:49:26.045', '2018-11-07 10:05:11.007', 944.962, 'success', 1, 'ca61a2f4ab13', 'airflow', 145, NULL, 'default', 3, 'SSHOperator', '2018-11-07 09:49:24.573', 493, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:19:42.094', '2018-11-08 03:41:25.059', 1302.96, 'success', 1, '6a0f258e32e2', 'airflow', 388, NULL, 'default', 3, 'SSHOperator', '2018-11-08 03:19:40.594', 709, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:36:32.613', '2018-11-09 03:50:39.925', 847.312, 'success', 1, '6a0f258e32e2', 'airflow', 1672, NULL, 'default', 3, 'SSHOperator', '2018-11-09 03:36:30.970', 1431, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:09:09.336', '2018-11-10 03:39:27.223', 1817.89, 'success', 1, 'a8d6517382cf', 'airflow', 3159, NULL, 'default', 3, 'SSHOperator', '2018-11-10 03:09:07.669', 21065, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:12:33.306', '2018-11-11 04:29:44.360', 1031.05, 'success', 1, 'a8d6517382cf', 'airflow', 4136, NULL, 'default', 3, 'SSHOperator', '2018-11-11 04:06:48.950', 2918, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:24:56.798', '2018-11-12 04:36:27.566', 690.768, 'success', 1, 'a8d6517382cf', 'airflow', 5060, NULL, 'default', 3, 'SSHOperator', '2018-11-12 04:24:07.989', 16721, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:08:48.247', '2018-11-13 04:28:25.248', 1177, 'success', 1, 'a8d6517382cf', 'airflow', 5966, NULL, 'default', 3, 'SSHOperator', '2018-11-13 04:08:26.044', 30413, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 10:30:21.468', '2018-11-07 10:49:37.621', 1156.15, 'success', 1, 'ca61a2f4ab13', 'airflow', 155, NULL, 'default', 1, 'SSHOperator', '2018-11-07 10:30:19.984', 598, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 04:44:49.541', '2018-11-08 05:20:53.573', 2164.03, 'success', 1, '6a0f258e32e2', 'airflow', 424, NULL, 'default', 1, 'SSHOperator', '2018-11-08 04:44:45.914', 1112, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 04:06:18.069', '2018-11-09 04:28:21.317', 1323.25, 'success', 1, '6a0f258e32e2', 'airflow', 1711, NULL, 'default', 1, 'SSHOperator', '2018-11-09 04:06:16.703', 1958, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:57:18.961', '2018-11-10 04:18:50.636', 1291.68, 'success', 1, 'a8d6517382cf', 'airflow', 3239, NULL, 'default', 1, 'SSHOperator', '2018-11-10 03:57:16.892', 22159, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:03:13.179', '2018-11-11 05:30:16.051', 1622.87, 'success', 1, 'a8d6517382cf', 'airflow', 4182, NULL, 'default', 1, 'SSHOperator', '2018-11-11 05:03:11.631', 3530, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:45:02.760', '2018-11-12 05:00:54.825', 952.065, 'success', 1, 'a8d6517382cf', 'airflow', 5093, NULL, 'default', 1, 'SSHOperator', '2018-11-12 04:45:01.043', 17163, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_monthly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:39:43.929', '2018-11-13 04:53:45.952', 842.023, 'success', 1, 'a8d6517382cf', 'airflow', 5992, NULL, 'default', 1, 'SSHOperator', '2018-11-13 04:39:42.391', 30755, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 10:09:57.322', '2018-11-07 10:27:19.832', 1042.51, 'success', 1, 'ca61a2f4ab13', 'airflow', 151, NULL, 'default', 2, 'SSHOperator', '2018-11-07 10:09:55.966', 568, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:41:28.492', '2018-11-08 04:44:38.600', 3790.11, 'success', 1, '6a0f258e32e2', 'airflow', 393, NULL, 'default', 2, 'SSHOperator', '2018-11-08 03:41:26.913', 754, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:50:51.454', '2018-11-09 04:06:15.988', 924.535, 'success', 1, '6a0f258e32e2', 'airflow', 1682, NULL, 'default', 2, 'SSHOperator', '2018-11-09 03:50:50.020', 1565, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:39:38.676', '2018-11-10 03:57:12.473', 1053.8, 'success', 1, 'a8d6517382cf', 'airflow', 3212, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:39:36.885', 21777, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 04:29:54.350', '2018-11-11 05:03:02.639', 1988.29, 'success', 1, 'a8d6517382cf', 'airflow', 4162, NULL, 'default', 2, 'SSHOperator', '2018-11-11 04:29:52.805', 3285, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:36:30.470', '2018-11-12 04:44:51.274', 500.805, 'success', 1, 'a8d6517382cf', 'airflow', 5083, NULL, 'default', 2, 'SSHOperator', '2018-11-12 04:36:28.733', 17021, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_trackingevents_weekly_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:28:29.372', '2018-11-13 04:39:39.034', 669.662, 'success', 1, 'a8d6517382cf', 'airflow', 5990, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:28:27.715', 30740, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:16:20.269', '2018-11-07 11:16:30.605', 10.3365, 'success', 1, 'ca61a2f4ab13', 'airflow', 164, NULL, 'default', 2, 'SSHOperator', '2018-11-07 11:16:18.035', 621, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:54:40.388', '2018-11-08 03:54:50.589', 10.2014, 'success', 1, '6a0f258e32e2', 'airflow', 402, NULL, 'default', 2, 'SSHOperator', '2018-11-08 03:54:37.802', 806, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:54:40.859', '2018-11-09 03:54:51.119', 10.2598, 'success', 1, '6a0f258e32e2', 'airflow', 1685, NULL, 'default', 2, 'SSHOperator', '2018-11-09 03:54:38.862', 1588, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:16.906', '2018-11-10 03:41:27.360', 10.4542, 'success', 1, 'a8d6517382cf', 'airflow', 3215, NULL, 'default', 2, 'SSHOperator', '2018-11-10 03:41:14.162', 21814, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:35.438', '2018-11-11 05:11:46.932', 11.4948, 'success', 1, 'a8d6517382cf', 'airflow', 4187, NULL, 'default', 2, 'SSHOperator', '2018-11-11 05:11:33.461', 3583, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:00.884', '2018-11-12 04:51:13.499', 12.6157, 'success', 1, 'a8d6517382cf', 'airflow', 5097, NULL, 'default', 2, 'SSHOperator', '2018-11-12 04:50:58.552', 17186, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:21.577', '2018-11-13 04:41:35.071', 13.4941, 'success', 1, 'a8d6517382cf', 'airflow', 5999, NULL, 'default', 2, 'SSHOperator', '2018-11-13 04:41:19.266', 30834, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 11:21:21.246', '2018-11-07 11:54:58.225', 2016.98, 'success', 1, 'ca61a2f4ab13', 'airflow', 166, NULL, 'default', 1, 'SSHOperator', '2018-11-07 11:21:19.361', 696, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 03:55:01.459', '2018-11-08 04:42:30.061', 2848.6, 'success', 1, '6a0f258e32e2', 'airflow', 406, NULL, 'default', 1, 'SSHOperator', '2018-11-08 03:54:58.996', 882, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 03:55:02.712', '2018-11-09 04:03:12.070', 489.357, 'success', 1, '6a0f258e32e2', 'airflow', 1693, NULL, 'default', 1, 'SSHOperator', '2018-11-09 03:55:00.352', 1663, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 03:41:38.076', '2018-11-10 03:50:25.828', 527.752, 'success', 1, 'a8d6517382cf', 'airflow', 3219, NULL, 'default', 1, 'SSHOperator', '2018-11-10 03:41:35.499', 21889, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 05:11:57.186', '2018-11-11 05:23:46.189', 709.003, 'success', 1, 'a8d6517382cf', 'airflow', 4195, NULL, 'default', 1, 'SSHOperator', '2018-11-11 05:11:54.825', 3658, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 04:51:23.134', '2018-11-12 05:03:00.273', 697.14, 'success', 1, 'a8d6517382cf', 'airflow', 5101, NULL, 'default', 1, 'SSHOperator', '2018-11-12 04:51:20.797', 17261, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('rollup_wiki_visitors_pageviews_daily_insert', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 04:41:43.018', '2018-11-13 04:50:44.726', 541.708, 'success', 1, 'a8d6517382cf', 'airflow', 6003, NULL, 'default', 1, 'SSHOperator', '2018-11-13 04:41:40.796', 30909, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 02:23:51.291', '2018-11-07 02:23:52.727', 1.43638, 'success', 1, 'ca61a2f4ab13', 'airflow', 69, NULL, 'default', 61, 'DummyOperator', '2018-11-07 02:23:49.809', 62, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:20:18.124', '2018-11-08 02:20:19.577', 1.45247, 'success', 1, '6a0f258e32e2', 'airflow', 349, NULL, 'default', 61, 'DummyOperator', '2018-11-08 02:20:14.461', 207, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:20:19.539', '2018-11-09 02:20:20.879', 1.34008, 'success', 1, '6a0f258e32e2', 'airflow', 1563, NULL, 'default', 61, 'DummyOperator', '2018-11-09 02:20:15.607', 32499, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:20:07.003', '2018-11-10 02:20:08.469', 1.46637, 'success', 1, 'a8d6517382cf', 'airflow', 3114, NULL, 'default', 61, 'DummyOperator', '2018-11-10 02:20:05.600', 20494, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:20:21.583', '2018-11-11 02:20:23.040', 1.45681, 'success', 1, 'a8d6517382cf', 'airflow', 4012, NULL, 'default', 61, 'DummyOperator', '2018-11-11 02:20:20.201', 1547, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 02:20:16.361', '2018-11-12 02:20:17.711', 1.35088, 'success', 1, 'a8d6517382cf', 'airflow', 4935, NULL, 'default', 61, 'DummyOperator', '2018-11-12 02:20:14.977', 15280, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:20:15.976', '2018-11-13 02:20:17.384', 1.40828, 'success', 1, 'a8d6517382cf', 'airflow', 5850, NULL, 'default', 61, 'DummyOperator', '2018-11-13 02:20:14.517', 29024, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:13:54.795', '2018-11-07 08:14:01.277', 6.48191, 'success', 1, 'ca61a2f4ab13', 'airflow', 109, NULL, 'default', 58, 'SSHOperator', '2018-11-07 08:13:53.409', 133, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:20:49.056', '2018-11-08 02:20:55.593', 6.53664, 'success', 1, '6a0f258e32e2', 'airflow', 352, NULL, 'default', 58, 'SSHOperator', '2018-11-08 02:20:47.702', 248, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:20:49.725', '2018-11-09 02:20:58.103', 8.37802, 'success', 1, '6a0f258e32e2', 'airflow', 1568, NULL, 'default', 58, 'SSHOperator', '2018-11-09 02:20:48.111', 32581, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:20:39.708', '2018-11-10 02:20:48.021', 8.31283, 'success', 1, 'a8d6517382cf', 'airflow', 3117, NULL, 'default', 58, 'SSHOperator', '2018-11-10 02:20:38.173', 20535, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:20:53.798', '2018-11-11 02:21:02.801', 9.00356, 'success', 1, 'a8d6517382cf', 'airflow', 4015, NULL, 'default', 58, 'SSHOperator', '2018-11-11 02:20:52.435', 1588, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 02:20:59.762', '2018-11-12 02:21:06.453', 6.69079, 'success', 1, 'a8d6517382cf', 'airflow', 4938, NULL, 'default', 58, 'SSHOperator', '2018-11-12 02:20:58.360', 15321, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:20:50.107', '2018-11-13 02:20:57.164', 7.05761, 'success', 1, 'a8d6517382cf', 'airflow', 5853, NULL, 'default', 58, 'SSHOperator', '2018-11-13 02:20:46.670', 29065, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_refresh', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:45:52.646', '2018-11-07 08:46:02.213', 9.56699, 'success', 1, 'ca61a2f4ab13', 'airflow', 116, NULL, 'default', 24, 'SSHOperator', '2018-11-07 08:45:51.081', 165, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_refresh', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:02.302', '2018-11-08 02:43:11.944', 9.64227, 'success', 1, '6a0f258e32e2', 'airflow', 365, NULL, 'default', 24, 'SSHOperator', '2018-11-08 02:43:00.790', 396, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_refresh', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:02.276', '2018-11-09 02:40:12.587', 10.3113, 'success', 1, '6a0f258e32e2', 'airflow', 1591, NULL, 'default', 24, 'SSHOperator', '2018-11-09 02:39:58.626', 407, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_refresh', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:28.274', '2018-11-10 02:35:39.845', 11.5708, 'success', 1, 'a8d6517382cf', 'airflow', 3127, NULL, 'default', 24, 'SSHOperator', '2018-11-10 02:35:26.409', 20632, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_refresh', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:24.870', '2018-11-11 02:56:35.596', 10.7259, 'success', 1, 'a8d6517382cf', 'airflow', 4031, NULL, 'default', 24, 'SSHOperator', '2018-11-11 02:56:23.385', 1762, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_refresh', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:11:59.286', '2018-11-12 03:12:09.782', 10.4965, 'success', 1, 'a8d6517382cf', 'airflow', 4958, NULL, 'default', 24, 'SSHOperator', '2018-11-12 03:11:57.705', 15538, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_special_events_refresh', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:32.469', '2018-11-13 02:58:44.263', 11.794, 'success', 1, 'a8d6517382cf', 'airflow', 5870, NULL, 'default', 24, 'SSHOperator', '2018-11-13 02:58:30.922', 29239, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_create', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:10:47.323', '2018-11-07 08:10:53.812', 6.48918, 'success', 3, 'ca61a2f4ab13', 'airflow', 107, NULL, 'default', 59, 'SSHOperator', '2018-11-07 02:33:57.995', 118, 3, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_create', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:20:38.249', '2018-11-08 02:20:44.389', 6.1402, 'success', 1, '6a0f258e32e2', 'airflow', 351, NULL, 'default', 59, 'SSHOperator', '2018-11-08 02:20:36.701', 233, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_create', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:20:39.175', '2018-11-09 02:20:46.065', 6.8901, 'success', 1, '6a0f258e32e2', 'airflow', 1567, NULL, 'default', 59, 'SSHOperator', '2018-11-09 02:20:37.345', 32557, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_create', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:20:30.703', '2018-11-10 02:20:37.467', 6.76431, 'success', 1, 'a8d6517382cf', 'airflow', 3116, NULL, 'default', 59, 'SSHOperator', '2018-11-10 02:20:27.251', 20520, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_create', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:20:43.278', '2018-11-11 02:20:49.834', 6.55611, 'success', 1, 'a8d6517382cf', 'airflow', 4014, NULL, 'default', 59, 'SSHOperator', '2018-11-11 02:20:41.683', 1573, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_create', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 02:20:37.818', '2018-11-12 02:20:48.393', 10.5752, 'success', 1, 'a8d6517382cf', 'airflow', 4937, NULL, 'default', 59, 'SSHOperator', '2018-11-12 02:20:36.400', 15306, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_create', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:20:37.376', '2018-11-13 02:20:43.986', 6.60967, 'success', 1, 'a8d6517382cf', 'airflow', 5852, NULL, 'default', 59, 'SSHOperator', '2018-11-13 02:20:35.953', 29050, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_refresh', 'clickstream_view_special_v2.2', '2018-11-06 02:15:00.000', '2018-11-07 08:45:52.508', '2018-11-07 08:46:01.936', 9.4283, 'success', 1, 'ca61a2f4ab13', 'airflow', 115, NULL, 'default', 32, 'SSHOperator', '2018-11-07 08:45:51.081', 163, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_refresh', 'clickstream_view_special_v2.2', '2018-11-07 02:15:00.000', '2018-11-08 02:43:02.261', '2018-11-08 02:43:12.469', 10.2079, 'success', 1, '6a0f258e32e2', 'airflow', 364, NULL, 'default', 32, 'SSHOperator', '2018-11-08 02:43:00.790', 394, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_refresh', 'clickstream_view_special_v2.2', '2018-11-08 02:15:00.000', '2018-11-09 02:40:00.294', '2018-11-09 02:40:10.053', 9.75828, 'success', 1, '6a0f258e32e2', 'airflow', 1590, NULL, 'default', 32, 'SSHOperator', '2018-11-09 02:39:58.627', 405, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_refresh', 'clickstream_view_special_v2.2', '2018-11-09 02:15:00.000', '2018-11-10 02:35:28.222', '2018-11-10 02:35:39.487', 11.2652, 'success', 1, 'a8d6517382cf', 'airflow', 3126, NULL, 'default', 32, 'SSHOperator', '2018-11-10 02:35:26.409', 20630, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_refresh', 'clickstream_view_special_v2.2', '2018-11-10 02:15:00.000', '2018-11-11 02:56:24.889', '2018-11-11 02:56:35.951', 11.062, 'success', 1, 'a8d6517382cf', 'airflow', 4032, NULL, 'default', 32, 'SSHOperator', '2018-11-11 02:56:23.385', 1760, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_refresh', 'clickstream_view_special_v2.2', '2018-11-11 02:15:00.000', '2018-11-12 03:11:59.318', '2018-11-12 03:12:09.975', 10.6567, 'success', 1, 'a8d6517382cf', 'airflow', 4959, NULL, 'default', 32, 'SSHOperator', '2018-11-12 03:11:57.705', 15536, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('stg_view_events_refresh', 'clickstream_view_special_v2.2', '2018-11-12 02:15:00.000', '2018-11-13 02:58:32.460', '2018-11-13 02:58:45.060', 12.5999, 'success', 1, 'a8d6517382cf', 'airflow', 5869, NULL, 'default', 32, 'SSHOperator', '2018-11-13 02:58:30.922', 29237, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_create', 'operative_data_import_v2.0', '2018-11-08 10:00:00.000', '2018-11-09 10:43:53.248', '2018-11-09 10:44:25.343', 32.0954, 'success', 1, 'a8d6517382cf', 'airflow', 2035, NULL, 'default', 2, 'SSHOperator', '2018-11-09 10:43:51.653', 1289, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_create', 'operative_data_import_v2.0', '2018-11-09 10:00:00.000', '2018-11-10 10:37:29.813', '2018-11-10 10:37:58.316', 28.5024, 'success', 1, 'a8d6517382cf', 'airflow', 3506, NULL, 'default', 2, 'SSHOperator', '2018-11-10 10:37:28.403', 26103, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_create', 'operative_data_import_v2.0', '2018-11-10 10:00:00.000', '2018-11-11 10:38:09.205', '2018-11-11 10:38:38.569', 29.3634, 'success', 1, 'a8d6517382cf', 'airflow', 4438, NULL, 'default', 2, 'SSHOperator', '2018-11-11 10:38:07.853', 7383, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_create', 'operative_data_import_v2.0', '2018-11-11 10:00:00.000', '2018-11-12 10:37:37.912', '2018-11-12 10:38:06.299', 28.3863, 'success', 1, 'a8d6517382cf', 'airflow', 5353, NULL, 'default', 2, 'SSHOperator', '2018-11-12 10:37:36.517', 21103, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_create', 'operative_data_import_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:44:42.267', '2018-11-13 10:45:14.578', 32.3106, 'success', 1, 'a8d6517382cf', 'airflow', 6260, NULL, 'default', 2, 'SSHOperator', '2018-11-13 10:44:40.572', 2264, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_qubole', 'operative_data_import_v2.0', '2018-11-08 10:00:00.000', '2018-11-09 10:44:34.718', '2018-11-09 10:45:28.911', 54.1924, 'success', 1, 'a8d6517382cf', 'airflow', 2036, NULL, 'default', 1, 'QuboleOperator', '2018-11-09 10:44:33.327', 1304, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_qubole', 'operative_data_import_v2.0', '2018-11-09 10:00:00.000', '2018-11-10 10:38:01.028', '2018-11-10 10:38:43.675', 42.6468, 'success', 1, 'a8d6517382cf', 'airflow', 3507, NULL, 'default', 1, 'QuboleOperator', '2018-11-10 10:37:59.683', 26118, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_qubole', 'operative_data_import_v2.0', '2018-11-10 10:00:00.000', '2018-11-11 10:38:40.836', '2018-11-11 10:39:23.383', 42.5462, 'success', 1, 'a8d6517382cf', 'airflow', 4439, NULL, 'default', 1, 'QuboleOperator', '2018-11-11 10:38:39.254', 7398, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_qubole', 'operative_data_import_v2.0', '2018-11-11 10:00:00.000', '2018-11-12 10:38:09.162', '2018-11-12 10:38:56.868', 47.7061, 'success', 1, 'a8d6517382cf', 'airflow', 5354, NULL, 'default', 1, 'QuboleOperator', '2018-11-12 10:38:07.861', 21118, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('current_qubole', 'operative_data_import_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:45:23.495', '2018-11-13 10:46:06.819', 43.3241, 'success', 1, 'a8d6517382cf', 'airflow', 6261, NULL, 'default', 1, 'QuboleOperator', '2018-11-13 10:45:22.180', 2279, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_operative_data_import_v2.0', 'operative_data_import_v2.0', '2018-11-08 10:00:00.000', '2018-11-09 10:00:05.892', '2018-11-09 10:05:07.556', 301.665, 'success', 1, 'a8d6517382cf', 'airflow', 1939, NULL, 'default', 7, 'TimeDeltaSensor', '2018-11-09 10:00:04.346', 51, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_operative_data_import_v2.0', 'operative_data_import_v2.0', '2018-11-09 10:00:00.000', '2018-11-10 10:00:06.779', '2018-11-10 10:05:08.376', 301.597, 'success', 1, 'a8d6517382cf', 'airflow', 3483, NULL, 'default', 7, 'TimeDeltaSensor', '2018-11-10 10:00:05.429', 25842, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_operative_data_import_v2.0', 'operative_data_import_v2.0', '2018-11-10 10:00:00.000', '2018-11-11 10:00:06.282', '2018-11-11 10:05:07.926', 301.644, 'success', 1, 'a8d6517382cf', 'airflow', 4414, NULL, 'default', 7, 'TimeDeltaSensor', '2018-11-11 10:00:04.856', 7108, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_operative_data_import_v2.0', 'operative_data_import_v2.0', '2018-11-11 10:00:00.000', '2018-11-12 10:00:06.114', '2018-11-12 10:05:07.724', 301.611, 'success', 1, 'a8d6517382cf', 'airflow', 5329, NULL, 'default', 7, 'TimeDeltaSensor', '2018-11-12 10:00:04.737', 20827, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('delay_operative_data_import_v2.0', 'operative_data_import_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:00:11.553', '2018-11-13 10:05:13.019', 301.466, 'success', 1, 'a8d6517382cf', 'airflow', 6237, NULL, 'default', 7, 'TimeDeltaSensor', '2018-11-13 10:00:10.233', 2013, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'operative_data_import_v2.0', '2018-11-08 10:00:00.000', '2018-11-09 10:05:14.764', '2018-11-09 10:05:16.670', 1.90638, 'success', 1, 'a8d6517382cf', 'airflow', 1945, NULL, 'default', 6, 'DummyOperator', '2018-11-09 10:05:13.055', 118, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'operative_data_import_v2.0', '2018-11-09 10:00:00.000', '2018-11-10 10:05:16.609', '2018-11-10 10:05:18.267', 1.65802, 'success', 1, 'a8d6517382cf', 'airflow', 3489, NULL, 'default', 6, 'DummyOperator', '2018-11-10 10:05:15.076', 25902, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'operative_data_import_v2.0', '2018-11-10 10:00:00.000', '2018-11-11 10:05:15.649', '2018-11-11 10:05:17.067', 1.41839, 'success', 1, 'a8d6517382cf', 'airflow', 4421, NULL, 'default', 6, 'DummyOperator', '2018-11-11 10:05:14.195', 7177, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'operative_data_import_v2.0', '2018-11-11 10:00:00.000', '2018-11-12 10:05:14.864', '2018-11-12 10:05:16.161', 1.29731, 'success', 1, 'a8d6517382cf', 'airflow', 5334, NULL, 'default', 6, 'DummyOperator', '2018-11-12 10:05:13.573', 20881, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('root_grouping_node', 'operative_data_import_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:05:21.974', '2018-11-13 10:05:23.335', 1.36059, 'success', 1, 'a8d6517382cf', 'airflow', 6243, NULL, 'default', 6, 'DummyOperator', '2018-11-13 10:05:20.522', 2076, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_create', 'operative_data_import_v2.0', '2018-11-08 10:00:00.000', '2018-11-09 10:05:24.937', '2018-11-09 10:05:40.554', 15.6164, 'success', 1, 'a8d6517382cf', 'airflow', 1948, NULL, 'default', 5, 'SSHOperator', '2018-11-09 10:05:23.568', 159, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_create', 'operative_data_import_v2.0', '2018-11-09 10:00:00.000', '2018-11-10 10:05:28.997', '2018-11-10 10:05:42.016', 13.0195, 'success', 1, 'a8d6517382cf', 'airflow', 3491, NULL, 'default', 5, 'SSHOperator', '2018-11-10 10:05:25.618', 25937, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_create', 'operative_data_import_v2.0', '2018-11-10 10:00:00.000', '2018-11-11 10:05:27.887', '2018-11-11 10:05:40.752', 12.8642, 'success', 1, 'a8d6517382cf', 'airflow', 4423, NULL, 'default', 5, 'SSHOperator', '2018-11-11 10:05:24.554', 7216, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_create', 'operative_data_import_v2.0', '2018-11-11 10:00:00.000', '2018-11-12 10:05:25.539', '2018-11-12 10:05:37.698', 12.159, 'success', 1, 'a8d6517382cf', 'airflow', 5337, NULL, 'default', 5, 'SSHOperator', '2018-11-12 10:05:24.081', 20922, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_create', 'operative_data_import_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:05:32.399', '2018-11-13 10:05:46.036', 13.6373, 'success', 1, 'a8d6517382cf', 'airflow', 6244, NULL, 'default', 5, 'SSHOperator', '2018-11-13 10:05:31.039', 2098, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_insert', 'operative_data_import_v2.0', '2018-11-08 10:00:00.000', '2018-11-09 10:05:45.956', '2018-11-09 10:26:58.847', 1272.89, 'success', 1, 'a8d6517382cf', 'airflow', 1950, NULL, 'default', 4, 'SSHOperator', '2018-11-09 10:05:44.614', 187, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_insert', 'operative_data_import_v2.0', '2018-11-09 10:00:00.000', '2018-11-10 10:05:47.971', '2018-11-10 10:20:41.049', 893.079, 'success', 1, 'a8d6517382cf', 'airflow', 3492, NULL, 'default', 4, 'SSHOperator', '2018-11-10 10:05:46.584', 25952, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_insert', 'operative_data_import_v2.0', '2018-11-10 10:00:00.000', '2018-11-11 10:05:47.098', '2018-11-11 10:21:30.410', 943.312, 'success', 1, 'a8d6517382cf', 'airflow', 4424, NULL, 'default', 4, 'SSHOperator', '2018-11-11 10:05:45.452', 7232, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_insert', 'operative_data_import_v2.0', '2018-11-11 10:00:00.000', '2018-11-12 10:05:46.453', '2018-11-12 10:21:25.565', 939.112, 'success', 1, 'a8d6517382cf', 'airflow', 5338, NULL, 'default', 4, 'SSHOperator', '2018-11-12 10:05:45.125', 20937, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_insert', 'operative_data_import_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:05:54.134', '2018-11-13 10:27:44.223', 1310.09, 'success', 1, 'a8d6517382cf', 'airflow', 6246, NULL, 'default', 4, 'SSHOperator', '2018-11-13 10:05:52.805', 2126, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_refresh', 'operative_data_import_v2.0', '2018-11-08 10:00:00.000', '2018-11-09 10:27:04.653', '2018-11-09 10:43:42.719', 998.067, 'success', 1, 'a8d6517382cf', 'airflow', 2003, NULL, 'default', 3, 'SSHOperator', '2018-11-09 10:27:03.358', 874, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_refresh', 'operative_data_import_v2.0', '2018-11-09 10:00:00.000', '2018-11-10 10:20:52.387', '2018-11-10 10:37:18.482', 986.095, 'success', 1, 'a8d6517382cf', 'airflow', 3500, NULL, 'default', 3, 'SSHOperator', '2018-11-10 10:20:51.014', 26047, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_refresh', 'operative_data_import_v2.0', '2018-11-10 10:00:00.000', '2018-11-11 10:21:32.636', '2018-11-11 10:38:00.580', 987.945, 'success', 1, 'a8d6517382cf', 'airflow', 4433, NULL, 'default', 3, 'SSHOperator', '2018-11-11 10:21:31.342', 7340, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_refresh', 'operative_data_import_v2.0', '2018-11-11 10:00:00.000', '2018-11-12 10:21:32.992', '2018-11-12 10:37:36.262', 963.269, 'success', 1, 'a8d6517382cf', 'airflow', 5348, NULL, 'default', 3, 'SSHOperator', '2018-11-12 10:21:31.599', 21060, 1, 'stub');
INSERT INTO task_instance
(task_id, dag_id, execution_date, start_date, end_date, duration, state, try_number, hostname, unixname, job_id, pool, queue, priority_weight, operator, queued_dttm, pid, max_tries, executor_config)
VALUES('tables_refresh', 'operative_data_import_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:27:52.509', '2018-11-13 10:44:39.669', 1007.16, 'success', 1, 'a8d6517382cf', 'airflow', 6256, NULL, 'default', 3, 'SSHOperator', '2018-11-13 10:27:50.977', 2234, 1, 'stub');
INSERT INTO task_instance (task_id, dag_id, execution_date, start_date, end_date, duration, state)
VALUES('heartbeat', 'heartbeat_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:27:52.509', '2018-11-13 10:44:39.669', 1007.16, 'success');
INSERT INTO task_instance (task_id, dag_id, execution_date, start_date, end_date, duration, state)
VALUES('heartbeat', 'paused_dag_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:27:52.509', '2018-11-13 10:44:39.669', 1007.16, 'success');
INSERT INTO task_instance (task_id, dag_id, execution_date, start_date, end_date, duration, state)
VALUES('heartbeat', 'inactive_dag_v2.0', '2018-11-12 10:00:00.000', '2018-11-13 10:27:52.509', '2018-11-13 10:44:39.669', 1007.16, 'success');
