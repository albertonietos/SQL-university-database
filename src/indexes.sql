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