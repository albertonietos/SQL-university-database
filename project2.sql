/* Create tables */
CREATE TABLE Courses (
    courseCode TEXT PRIMARY KEY,
    courseName TEXT NOT NULL,
    credits    REAL CHECK (credits > 0) 
);

CREATE TABLE CourseInstances (
    instanceNo TEXT    PRIMARY KEY,
    year       INTEGER CHECK (year > 2000),
    semester   INTEGER CHECK (semester IN (1, 2) ),
    startDate  TEXT,
    endDate    TEXT,
    courseCode TEXT    REFERENCES Courses (courseCode) 
);

CREATE TABLE ExerciseGroups (
    groupNo      TEXT    PRIMARY KEY,
    studentLimit INTEGER CHECK (studentLimit > 0),
    instanceNo   TEXT    REFERENCES CourseInstances (instanceNo) 
);

CREATE TABLE Events (
    eventNo   TEXT PRIMARY KEY,
    date      TEXT,
    startTime TEXT,
    endTime   TEXT
);

CREATE TABLE Lectures (
    instanceNo TEXT,
    lectureNo  TEXT,
    eventNo    TEXT UNIQUE,
    PRIMARY KEY (
        instanceNo,
        lectureNo
    ),
    FOREIGN KEY (
        instanceNo
    )
    REFERENCES CourseInstances (instanceNo),
    FOREIGN KEY (
        eventNo
    )
    REFERENCES Events (eventNo) 
);

CREATE TABLE GroupMeetings (
    groupNo   TEXT,
    meetingNo TEXT,
    eventNo   TEXT UNIQUE,
    PRIMARY KEY (
        groupNo,
        meetingNo
    ),
    FOREIGN KEY (
        groupNo
    )
    REFERENCES ExerciseGroups (groupNo),
    FOREIGN KEY (
        eventNo
    )
    REFERENCES Events (eventNo) 
);

CREATE TABLE Exams (
    examNo        TEXT PRIMARY KEY,
    startExamTime TEXT,
    endExamTime   TEXT,
    courseCode    TEXT NOT NULL,
    eventNo       TEXT NOT NULL,
    FOREIGN KEY (
        courseCode
    )
    REFERENCES Courses (courseCode),
    FOREIGN KEY (
        eventNo
    )
    REFERENCES Events (eventNo) 
);

CREATE TABLE Students (
    studentID      TEXT    PRIMARY KEY,
    studentName    TEXT,
    birthdate      TEXT,
    program        TEXT,
    startYear      INTEGER,
    expirationDate TEXT
);

CREATE TABLE EnrollForExams (
    studentID TEXT,
    examNo    TEXT,
    PRIMARY KEY (
        studentID,
        examNo
    ),
    FOREIGN KEY (
        studentID
    )
    REFERENCES Students (studentID),
    FOREIGN KEY (
        examNo
    )
    REFERENCES Exams (examNo) 
);

CREATE TABLE EnrollForCourses (
    studentID TEXT,
    groupNo   TEXT,
    PRIMARY KEY (
        studentID,
        groupNo
    ),
    FOREIGN KEY (
        studentID
    )
    REFERENCES Students (studentID),
    FOREIGN KEY (
        groupNo
    )
    REFERENCES ExerciseGroups (groupNo) 
);

CREATE TABLE Buildings (
    buildingID   TEXT PRIMARY KEY,
    buildingName TEXT,
    address      TEXT UNIQUE
);

CREATE TABLE Rooms (
    buildingID TEXT,
    roomID     TEXT,
    size       INTEGER,
    examSize   INTEGERR,
    PRIMARY KEY (
        buildingID,
        roomID
    ),
    FOREIGN KEY (
        buildingID
    )
    REFERENCES Buildings (buildingID),
    CHECK (size >= examSize) 
);

CREATE TABLE Equipments (
    equipmentID   TEXT PRIMARY KEY,
    equipmentName TEXT NOT NULL,
    buildingID    TEXT,
    roomID        TEXT,
    FOREIGN KEY (
        buildingID,
        roomID
    )
    REFERENCES Rooms (buildingID,
    roomID) 
);


CREATE TABLE VideoProjectors (
    equipmentID TEXT PRIMARY KEY,
    FOREIGN KEY (
        equipmentID
    )
    REFERENCES Equipments (equipmentID) 
);

CREATE TABLE TwoVideoProjectors (
    equipmentID TEXT PRIMARY KEY,
    FOREIGN KEY (
        equipmentID
    )
    REFERENCES Equipments (equipmentID) 
);

CREATE TABLE Computers (
    equipmentID TEXT PRIMARY KEY,
    users       TEXT NOT NULL,
    FOREIGN KEY (
        equipmentID
    )
    REFERENCES Equipments (equipmentID) 
);

CREATE TABLE DocumentCameras (
    equipmentID TEXT PRIMARY KEY,
    FOREIGN KEY (
        equipmentID
    )
    REFERENCES Equipments (equipmentID) 
);

CREATE TABLE Reserve (
    eventNo    TEXT UNIQUE,
    buildingID TEXT NOT NULL,
    roomID     TEXT NOT NULL,
    FOREIGN KEY (
        eventNo
    )
    REFERENCES Events (eventNo),
    FOREIGN KEY (
        buildingID,
        roomID
    )
    REFERENCES Rooms (buildingID,
    roomID) 
);

/* Insert tuples */
INSERT INTO Courses
VALUES ('CS-A1150', 'Databases', 5);

INSERT INTO Courses
VALUES ('CS-E4800', 'Artificial Intelligence', 5);

INSERT INTO Courses
VALUES ('CS-E4610', 'Modern Database Systems', 5);

INSERT INTO Courses
VALUES ('CS-C3100', 'Computer Graphics', 5);

INSERT INTO CourseInstances
VALUES ('CS-A1150-2020-1', 2020, 1, '2020-09-03', '2020-11-20', 'CS-A1150');

INSERT INTO CourseInstances
VALUES ('CS-E4800-2020-1', 2020, 1, '2020-09-01', '2020-12-27', 'CS-E4800');

INSERT INTO CourseInstances
VALUES ('CS-E4610-2020-1', 2020, 1, '2021-09-07', '2021-11-23', 'CS-E4610');

INSERT INTO CourseInstances
VALUES ('CS-E4610-2020-2', 2020, 2, '2021-01-05', '2021-04-05', 'CS-E4610');

INSERT INTO ExerciseGroups
VALUES ('CS-A1150-group1', 10, 'CS-A1150-2020-1');

INSERT INTO Events
VALUES ('20200903L1', '2020-09-03', '09:00', '12:00');

INSERT INTO Events
VALUES ('20200904M1', '2020-09-04', '10:00', '11:00');

INSERT INTO Events
VALUES ('20201125E1', '2020-11-25', '08:30', '09:30');

INSERT INTO Lectures
VALUES ('CS-A1150-2020-1', 'lecture1', '20200903L1');

INSERT INTO Lectures(instanceNo, lectureNo)
VALUES ('CS-A1150-2020-1', 'lecture2');

INSERT INTO GroupMeetings
VALUES ('CS-A1150-group1', 'meeting1', '20200904M1');

INSERT INTO GroupMeetings(groupNo, meetingNo)
VALUES ('CS-A1150-group1', 'meeting2');

INSERT INTO Exams
VALUES ('CS-A1150-exam1', '08:40', '09:30', 'CS-A1150', '20201125E1');

INSERT INTO Students
VALUES ('112233', 'Teemu Teekkari', '1990-05-11', 'TIK', '2017', '2021-08-30');

INSERT INTO Students
VALUES ('123456', 'Tiina Teekkari', '1992-09-23', 'TUO', '2019', '2023-08-30');

INSERT INTO Students
VALUES ('224411', 'Maija Virtanen', '1991-12-05', 'AUT', '2018', '2022-08-30');

INSERT INTO EnrollForExams
VALUES ('112233', 'CS-A1150-exam1');

INSERT INTO EnrollForExams
VALUES ('224411', 'CS-A1150-exam1');

INSERT INTO EnrollForCourses
VALUES ('112233', 'CS-A1150-group1');

INSERT INTO Buildings
VALUES ('building1', 'Computer Science Building', 'Tietotekniikantalo, Konemiehentie 2, 02150 Espoo');

INSERT INTO Buildings
VALUES ('building2', 'Engineering Physics Building', 'Tietotekniikantalo, Konemiehentie 4, 02150 Espoo');

INSERT INTO Rooms
VALUES ('building1', 'room101', 30, 20);

INSERT INTO Rooms
VALUES ('building1', 'C206', 45, 30);

INSERT INTO Rooms
VALUES ('building2', 'C310', 50, 30);

INSERT INTO Equipments
VALUES ('equipment1', 'MacComputer', 'building1', 'room101');

INSERT INTO Equipments
VALUES ('equipment2', 'SONY VideoProject', 'building1', 'room101');

INSERT INTO VideoProjectors
VALUES ('equipment2');

INSERT INTO Computers
VALUES ('equipment1', 'teachers');

INSERT INTO Reserve
VALUES ('20200903L1', 'building1', 'room101');

INSERT INTO Reserve
VALUES ('20201125E1', 'building1', 'C206'); 

/* Create views */
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

/* Create indexes */
CREATE INDEX idx_student ON Students (
    studentID
);

CREATE INDEX idx_courses ON Courses (
    courseCode
);

CREATE INDEX idx_course_instances ON CourseInstances (
    year,
    semester
);

CREATE INDEX idx_enroll_exams ON EnrollForExams (
    studentID
);

CREATE INDEX idx_enroll_courses ON EnrollForCourses (
    studentID
);

CREATE INDEX idx_events ON Events (
    eventNo
);
CREATE INDEX idx_reserve ON Reserve (
    eventNo
);


/* Typical queries */

/* Query all distinct courses (course code and name) taken place during the first semester of 2020 */
SELECT DISTINCT courseCode, courseName
  FROM CourseInstances AS CI,
       Courses AS C
 WHERE CI.courseCode = C.courseCode AND 
       year = 2020 AND 
       semester = 1;

/* Query all courses that contain the word 'Database' in their name */
SELECT courseName
  FROM Courses
 WHERE courseName LIKE '%Database%';

/* Find how many courses take place per semester and year*/
SELECT year,
       semester,
       COUNT(instanceNo) AS total
  FROM CourseInstances
 GROUP BY year,
          semester;

/* Find how many instances of each course are scheduled.
Those courses with no instances scheduled must also be listed.
Order the courses based on the number of instances in a descending fashion. */
SELECT courseName as Course,
       COUNT(instanceNo) AS Instances
  FROM Courses
       LEFT OUTER JOIN
       CourseInstances ON CourseInstances.courseCode = Courses.courseCode
 GROUP BY courseName
 ORDER BY instances DESC;

/* Query the exact number and the limit number of students in one group */
SELECT EnrollForCourses.groupNo,
       COUNT(studentID),
       studentLimit
  FROM EnrollForCourses,
       ExerciseGroups
 WHERE EnrollForCourses.groupNo = ExerciseGroups.groupNo
 GROUP BY EnrollForCourses.groupNo;

/* Query the exact number of students in one exam */
SELECT examNo,
       COUNT(studentID) 
  FROM EnrollForExams
 GROUP BY examNo;

/* Query the exact number of students in a study group */
SELECT groupNo,
       COUNT(studentID) 
  FROM EnrollForCourses
 GROUP BY groupNo;


/* Find the course codes and names of all the course that are organized during the second semester,
 but not in the second semester. */
SELECT courseCode,
       courseName
  FROM Courses
 WHERE courseCode IN (
           SELECT courseCode
             FROM courseInstances
            WHERE semester = 1
       )
AND 
       courseCode NOT IN (
           SELECT courseCode
             FROM courseInstances
            WHERE semester = 2
       );

/* Query the number of computers in one room which could used by students to have a lecture or exam */
SELECT buildingID,
       roomID,
       COUNT(Computers.equipmentID) 
  FROM Computers,
       Equipments
 WHERE users = 'students' AND 
       Computers.equipmentID = Equipments.equipmentID
 GROUP BY buildingID,
          roomID;

/* Find a room which has at least 20 seats and which is free for reservation at a certain time (2020-09-03 at 9:00 to 10:00).
List the room ID and the address of the room where the building is located.
*/ 

/* In order to select those rooms without a reservation, 3 different conditions can occur:
    - The room has no reservations for that day
    - The room has a reservation in that day, but not within the specified times
    - The room has no reservations at all (it is not found in the Reserve relation).
   Besides this, we just have to make sure that the room has space for more than 20 people.
In this first query, one of the rooms has an event in that day and within the given timeframe.
The others are available.
*/

SELECT roomID,
       buildingName,
       address
  FROM Rooms,
       Buildings
 WHERE Rooms.buildingID = Buildings.buildingID AND 
       size >= 20
EXCEPT
SELECT Reserve.roomID,
       buildingName,
       address
  FROM Reserve,
       Events,
       Rooms,
        Buildings
 WHERE Rooms.buildingID = Buildings.buildingID AND 
       Reserve.eventNo = Events.eventNo AND 
       Reserve.roomID = Rooms.roomID AND 
       date = '2020-09-03' AND 
       ( (TIME('09:00') >= startTime AND 
          TIME('09:00') < endTime) OR 
         (TIME('10:00') > startTime AND 
          TIME('10:00') <= endTime) OR 
         (TIME('09:00') < startTime AND 
          TIME('10:00') > endTime) );

/* In this second query, there are no reservations for any Event on 2020-09-05, so all the rooms that 
have been inserted in the database are present. No matter if they have any scheduled event at some point or not.*/
SELECT roomID,
       buildingName,
       address
  FROM Rooms,
       Buildings
 WHERE Rooms.buildingID = Buildings.buildingID AND 
       size >= 20
EXCEPT
SELECT Reserve.roomID,
       buildingName,
       address
  FROM Reserve,
       Events,
       Rooms,
        Buildings
 WHERE Rooms.buildingID = Buildings.buildingID AND 
       Reserve.eventNo = Events.eventNo AND 
       Reserve.roomID = Rooms.roomID AND 
       date = '2020-09-05' AND 
       ( (TIME('09:00') >= startTime AND 
          TIME('09:00') < endTime) OR 
         (TIME('10:00') > startTime AND 
          TIME('10:00') <= endTime) OR 
         (TIME('09:00') < startTime AND 
          TIME('10:00') > endTime) );

/* Find out for which purpose a certain room is reserved at a certain time. 
For example, is there some event in room C206 from the Computer Science Building 
on 2020-11-25 between 08:30 and 10:30?*/

/* The query should return empty if no events are scheduled, or it will return the EventNo 
that identifies which kind of event is scheduled and its schedule.
If there is an event that overlaps the time that is given, it will be shown as well.
No matter how small the time overlap is.*/
SELECT DISTINCT eventNo,
                startTime,
                endTime
  FROM Events,
       Reserve,
       Rooms,
       Buildings
 WHERE Events.eventNo = Reserve.eventNo AND 
       Reserve.roomID = Rooms.roomID AND
       Rooms.buildingID = Buildings.buildingID AND 
       Rooms.roomID = 'C206' AND 
       Buildings.buildingName = 'Computer Science Building' AND 
       date = '2020-11-25' AND 
       (
           (TIME(startTime) <= TIME('08:30') AND TIME(endTime) > TIME('08:30') ) 
           OR 
           (TIME(startTime) > TIME('08:30') AND TIME(startTime) < TIME('10:30') )
        );

/* Now, we will check another room (e.g. room101) of the same building for the same time schedule.
Since the previous one had an Event (Exam because of the code).
*/
SELECT DISTINCT eventNo,
                startTime,
                endTime
  FROM Events,
       Reserve,
       Rooms,
       Buildings
 WHERE Events.eventNo = Reserve.eventNo AND 
       Reserve.roomID = Rooms.roomID AND
       Rooms.buildingID = Buildings.buildingID AND 
       Rooms.roomID = 'room101' AND 
       Buildings.buildingName = 'Computer Science Building' AND 
       date = '2020-11-25' AND 
       (
           (TIME(startTime) <= TIME('08:30') AND TIME(endTime) > TIME('08:30') ) 
           OR 
           (TIME(startTime) > TIME('08:30') AND TIME(startTime) < TIME('10:30') )
        );
        
/* As we can see, no tuples are returned and, thus, we can book this room for this time schedule freely.*/


/* List all exams that are scheduled, the course name and where and when it is scheduled to take place.
Now, we can use the view that we created earlier 'ExamTimePlace' to make the query much simpler.*/ 
SELECT examNo,
       courseName,
       date,
       startExamTime AS start,
       endExamTime AS end,
       roomId,
       buildingName
  FROM ExamTimePlace,
       Courses,
       Buildings
 WHERE ExamTimePlace.courseCode = Courses.courseCode AND 
       ExamTimePlace.buildingID = Buildings.buildingID;


/* List all students who have enrolled for a exam in the Databases course.
List the student name, the program they are in, which exam they are enrolled in (multiple exams
per year in a course are possible) and the date of the exam.*/
SELECT studentName,
       program,
       examNo,
       date
  FROM EnrollForExams,
       Exams,
       Courses,
       Students,
       Events
 WHERE EnrollForExams.studentID = Students.studentID AND 
       EnrollForExams.examNo = Exams.examNo AND 
       Exams.courseCode = Courses.courseCode AND 
       Exams.eventNo = Events.eventNo AND
       Courses.courseName = 'Databases';

/* For a particular course instance (e.g. 'CS-A1150-2020-1'), list the exercise groups that are not full yet. 
List how many students are enrolled in those groups that are not full.*/
SELECT EnrollForCourses.groupNo,
       COUNT(studentID) AS totalStudents
  FROM EnrollForCourses,
       ExerciseGroups
 WHERE EnrollForCourses.groupNo = ExerciseGroups.groupNo
 GROUP BY EnrollForCourses.groupNo
HAVING COUNT(studentID) < ExerciseGroups.studentLimit;

/* Find out, when a certain course has been arranged or when it will be arranged */
SELECT courseName,
       year,
       semester,
       startDate,
       endDate
  FROM CourseInstances,
       Courses
 WHERE CourseInstances.courseCode = Courses.courseCode
 ORDER BY startDate, endDate;
/* As we can see the course Modern Database Systems is organized twice in 2020.
The course instances that are listed are ordered by their start date (starting the earliest).
If they would have the same start date, the order would be determined by the end date (earliest first). */

/* Delete student given a studentID ('112233') from course registration in course with course code CS-A1150. 
After deletion, the student is no longer registered in the exercise group and, thus, not in the course either.*/
DELETE FROM EnrollForCourses
      WHERE studentID = '112233' AND 
            groupNo LIKE 'CS-A1150%';
            
/*In this case, the teacher plans to organise a course instance. 
He need query whether there is already an course instance for the Computer Graphics recently. 
If there is schedule, the teacher wants to update the startDate and endDate. 
If there is no schedule, the teacher wants to insert one.*/
SELECT Courses.courseCode,
       instanceNo,
       credits,
       year,
       semester,
       startDate,
       endDate
  FROM Courses
       LEFT OUTER JOIN
       CourseInstances ON Courses.courseCode = CourseInstances.courseCode
 WHERE courseName = 'Computer Graphics';
 -- Now the teacher finds theres is no such course instance, so he wants to insert one.
INSERT INTO CourseInstances VALUES (
                                'CS-C3100-2020-1',
                                2020,
                                1,
                                '2021-01-05',
                                '2020-04-20',
                                'CS-C3100'
                            );
-- Later the teacher wants to change the start date, he wants to update it.
UPDATE CourseInstances
   SET startDate = '2021-01-02'
 WHERE instanceNo = 'CS-C3100-2020-1';

-- When we execute the query now, we obtain the following
SELECT Courses.courseCode,
       instanceNo,
       credits,
       year,
       semester,
       startDate,
       endDate
  FROM Courses
       LEFT OUTER JOIN
       CourseInstances ON Courses.courseCode = CourseInstances.courseCode
 WHERE courseName = 'Computer Graphics';

