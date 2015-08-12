alter table mon.alarm modify column state varchar(20) NOT NULL;
alter table mon.alarm_action modify column alarm_state varchar(20) NOT NULL;
alter table mon.notification_method modify column type varchar(20) NOT NULL;
alter table mon.stream_actions modify column action_type varchar(20) NOT NULL;
alter table mon.alarm_definition modify column severity varchar(20) NOT NULL;

-- applying conversion from medium text to longtext
alter table mon.alarm_definition modify column expression longtext COLLATE utf8mb4_unicode_ci NOT NULL;
alter table mon.sub_alarm modify column expression longtext COLLATE utf8mb4_unicode_ci NOT NULL;

alter table mon.stream_definition modify column select_by longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL;
alter table mon.stream_definition modify column group_by longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL;
alter table mon.stream_definition modify column fire_criteria longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL;

alter table mon.event_transform modify column specification longtext COLLATE utf8mb4_unicode_ci NOT NULL;
