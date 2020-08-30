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