alter table mon.alarm_definition modify column expression longtext COLLATE utf8mb4_unicode_ci NOT NULL;
alter table mon.sub_alarm modify column expression longtext COLLATE utf8mb4_unicode_ci NOT NULL;

alter table mon.stream_definition modify column select_by longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL;
alter table mon.stream_definition modify column group_by longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL;
alter table mon.stream_definition modify column fire_criteria longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL;

alter table mon.event_transform modify column specification longtext COLLATE utf8mb4_unicode_ci NOT NULL;
