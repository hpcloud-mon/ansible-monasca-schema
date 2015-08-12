DROP TRIGGER IF EXISTS mon.before_alarm_insert;
DROP TRIGGER IF EXISTS mon.before_alarm_update;
DROP TRIGGER IF EXISTS mon.before_alarm_action_insert;
DROP TRIGGER IF EXISTS mon.before_alarm_action_update;
DROP TRIGGER IF EXISTS mon.before_alarm_definition_insert;
DROP TRIGGER IF EXISTS mon.before_alarm_definition_update;
DROP TRIGGER IF EXISTS mon.before_notification_method_insert;
DROP TRIGGER IF EXISTS mon.before_notification_method_update;
DROP TRIGGER IF EXISTS mon.before_stream_actions_insert;
DROP TRIGGER IF EXISTS mon.before_stream_actions_update;

DELIMITER &&

CREATE TRIGGER mon.before_alarm_insert
BEFORE INSERT
ON alarm FOR EACH ROW
BEGIN
  SET @validValues = 'UNDETERMINED,OK,ALARM';
  SET @isFound = (SELECT FIND_IN_SET(new.state, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for alarm.state, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

CREATE TRIGGER mon.before_alarm_update
BEFORE UPDATE
ON alarm FOR EACH ROW
BEGIN
  SET @validValues = 'UNDETERMINED,OK,ALARM';
  SET @isFound = (SELECT FIND_IN_SET(new.state, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for alarm.state, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&
CREATE TRIGGER mon.before_alarm_action_insert
BEFORE INSERT
ON alarm_action FOR EACH ROW
BEGIN
  SET @validValues = 'UNDETERMINED,OK,ALARM';
  SET @isFound = (SELECT FIND_IN_SET(new.alarm_state, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for alarm_action.alarm_state, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

CREATE TRIGGER mon.before_alarm_action_update
BEFORE UPDATE
ON alarm_action FOR EACH ROW
BEGIN
  SET @validValues = 'UNDETERMINED,OK,ALARM';
  SET @isFound = (SELECT FIND_IN_SET(new.alarm_state, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for alarm_action.alarm_state, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

CREATE TRIGGER mon.before_alarm_definition_insert
BEFORE INSERT
ON alarm_definition FOR EACH ROW
BEGIN
  SET @validValues = 'LOW,MEDIUM,HIGH,CRITICAL';
  SET @isFound = (SELECT FIND_IN_SET(new.severity, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for alarm_definition.severity, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

CREATE TRIGGER mon.before_alarm_definition_update
BEFORE UPDATE
ON alarm_definition FOR EACH ROW
BEGIN
  SET @validValues = 'LOW,MEDIUM,HIGH,CRITICAL';
  SET @isFound = (SELECT FIND_IN_SET(new.severity, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for alarm_definition.severity, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

CREATE TRIGGER mon.before_notification_method_insert
BEFORE INSERT
ON notification_method FOR EACH ROW
BEGIN
  SET @validValues = 'EMAIL,WEBHOOK,PAGERDUTY';
  SET @isFound = (SELECT FIND_IN_SET(new.type, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for notification_method.type, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

CREATE TRIGGER mon.before_notification_method_update
BEFORE UPDATE
ON notification_method FOR EACH ROW
BEGIN
  SET @validValues = 'EMAIL,WEBHOOK,PAGERDUTY';
  SET @isFound = (SELECT FIND_IN_SET(new.type, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for notification_method.type, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

CREATE TRIGGER mon.before_stream_actions_insert
BEFORE INSERT
ON stream_actions FOR EACH ROW
BEGIN
  SET @validValues = 'FIRE,EXPIRE';
  SET @isFound = (SELECT FIND_IN_SET(new.action_type, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for stream_actions.action_type, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

CREATE TRIGGER mon.before_stream_actions_update
BEFORE UPDATE
ON stream_actions FOR EACH ROW
BEGIN
  SET @validValues = 'FIRE,EXPIRE';
  SET @isFound = (SELECT FIND_IN_SET(new.action_type, @validValues));

  IF @isFound < 1 THEN
    SET @msg = (SELECT CONCAT('check constraint failed for stream_actions.action_type, value not in ', @validValues));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
END&&

DELIMITER ;
