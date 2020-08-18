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
