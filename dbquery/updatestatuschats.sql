UPDATE
  chat
SET
  status = '%s',
  deliveredDate = '$s',
WHERE
  messageId IN (%s)