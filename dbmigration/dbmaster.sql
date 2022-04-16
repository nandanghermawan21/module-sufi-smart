CREATE TABLE chat (
  id INTEGER PRIMARY KEY,
  creteDate DATETIME,
  messageType VARCHAR(50),
  sender VARCHAR(50),
  receiver VARCHAR(50),
  message TEXT,
  notificationId VARCHAR(50),
  status int,
  receivedDate DATETIME,
  deliveredDate DATETIME
)