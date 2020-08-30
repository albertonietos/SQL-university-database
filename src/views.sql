CREATE VIEW LectureTimePlace AS
    SELECT instanceNo,
           lectureNo,
           date,
           startTime,
           endTime,
           buildingID,
           roomID
      FROM (
               SELECT instanceNo,
                      lectureNo,
                      Lectures.eventNo,
                      date,
                      startTime,
                      endTime
                 FROM Lectures
                      LEFT JOIN
                      Events ON Lectures.eventNo = Events.eventNo
           )
           AS LectureTime
           LEFT JOIN
           Reserve ON LectureTime.eventNo = Reserve.eventNo;

CREATE VIEW MeetingTimePlace AS
    SELECT groupNo,
           meetingNo,
           date,
           startTime,
           endTime,
           buildingID,
           roomID
      FROM (
               SELECT groupNo,
                      meetingNo,
                      GroupMeetings.eventNo,
                      date,
                      startTime,
                      endTime
                 FROM GroupMeetings
                      LEFT JOIN
                      Events ON GroupMeetings.eventNo = Events.eventNo
           )
           AS MeetingTime
           LEFT JOIN
           Reserve ON MeetingTime.eventNo = Reserve.eventNo;

CREATE VIEW ExamTimePlace AS
    SELECT courseCode,
           examNo,
           startExamTime,
           endExamTime,
           date,
           startTime,
           endTime,
           buildingID,
           roomID
      FROM (
               SELECT courseCode,
                      examNo,
                      Exams.eventNo,
                      startExamTime,
                      endExamTime,
                      date,
                      startTime,
                      endTime
                 FROM Exams
                      LEFT JOIN
                      Events ON Exams.eventNo = Events.eventNo
           )
           AS ExamTime
           LEFT JOIN
           Reserve ON ExamTime.eventNo = Reserve.eventNo;