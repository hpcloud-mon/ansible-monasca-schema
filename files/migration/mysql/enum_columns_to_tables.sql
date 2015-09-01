-- create new tables
CREATE TABLE mon.alarm_state (
  name varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE mon.alarm_definition_severity (
  name varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE mon.notification_method_type (
  name varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE mon.stream_actions_action_type (
  name varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- insert data into ...
-- alarm_state
INSERT INTO mon.alarm_state VALUES ('UNDETERMINED');
INSERT INTO mon.alarm_state VALUES ('OK');
INSERT INTO mon.alarm_state VALUES ('ALARM');

-- alarm_definition_severity
INSERT INTO mon.alarm_definition_severity VALUES ('LOW');
INSERT INTO mon.alarm_definition_severity VALUES ('MEDIUM');
INSERT INTO mon.alarm_definition_severity VALUES ('HIGH');
INSERT INTO mon.alarm_definition_severity VALUES ('CRITICAL');

-- notification_method_type
INSERT INTO mon.notification_method_type VALUES ('EMAIL');
INSERT INTO mon.notification_method_type VALUES ('WEBHOOK');
INSERT INTO mon.notification_method_type VALUES ('PAGERDUTY');

-- stream_actions_action_type
INSERT INTO mon.stream_actions_action_type VALUES ('FIRE');
INSERT INTO mon.stream_actions_action_type VALUES ('EXPIRE');

DROP TABLE IF EXISTS mon.enum_migration_dict;
CREATE TEMPORARY TABLE mon.enum_migration_dict (
  t_name      VARCHAR(50), -- target table
  e_table     VARCHAR(50), -- source table (enum table)
  c_name      VARCHAR(50)  -- column in target table
) ENGINE = MEMORY;

INSERT INTO mon.enum_migration_dict VALUES ('alarm', 'alarm_state', 'state');
INSERT INTO mon.enum_migration_dict VALUES ('alarm_definition', 'alarm_definition_severity', 'severity');
INSERT INTO mon.enum_migration_dict VALUES ('notification_method', 'notification_method_type', 'type');
INSERT INTO mon.enum_migration_dict VALUES ('alarm_action', 'alarm_state', 'alarm_state');
INSERT INTO mon.enum_migration_dict VALUES ('stream_actions', 'stream_actions_action_type', 'action_type');

DELIMITER //
CREATE PROCEDURE mon.migrate_tables()
  BEGIN
    DECLARE _table VARCHAR(50);
    DECLARE _column VARCHAR(50);
    DECLARE _enumTable VARCHAR(50);

    DECLARE done INT DEFAULT 0;
    DECLARE dictCursor CURSOR FOR (SELECT * FROM mon.enum_migration_dict);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN dictCursor;
    migrate_loop: LOOP
      FETCH dictCursor INTO _table, _enumTable, _column;

      IF done = 1
      THEN
        LEAVE migrate_loop;
      END IF;

      SET @table := _table;
      SET @enumTable := _enumTable;
      SET @column := _column;

      -- 1. alter _column
      SET @sqlText1 := concat('alter table ', @table, ' modify column ', @column, ' varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL');
      SELECT @sqlText1 AS '1';
      PREPARE changeColStmt FROM @sqlText1;
      EXECUTE changeColStmt;
      SELECT concat('1. Affected ', @column, ' in table ', @table, ' [rows affected=', row_count(), ']') AS 'Message';
      DEALLOCATE PREPARE changeColStmt;

      -- 2. add foreign key index
      SET @sqlText2 := concat('alter table ', @table, ' add constraint fk_', @enumTable, '_', @table, ' foreign key (', @column, ') references ', @enumTable, ' (name)');
      SELECT @sqlText2 AS '2';
      PREPARE fkStmt FROM @sqlText2;
      EXECUTE fkStmt;
      SELECT concat('2. Added foreign key on ', @column, ' to table ', @table, ' [rows affected=', row_count(), ']') AS 'Message';
      DEALLOCATE PREPARE fkStmt;

    END LOOP migrate_loop;
    CLOSE dictCursor;
    DROP TABLE IF EXISTS tmp_table;

  END//

DELIMITER ;

SET foreign_key_checks = 0;
CALL mon.migrate_tables();
SET foreign_key_checks = 1;

DROP PROCEDURE mon.migrate_tables;
DROP TABLE mon.enum_migration_dict;
