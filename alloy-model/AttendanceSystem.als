// =====================================
// Attendance Management System (Alloy)
// Structural Verification Model
// =====================================

// ---------- Student ----------
sig Student {
    id: one Int,
    name: one String
}

// ---------- Course ----------
sig Course {
    code: one Int,
    title: one String
}

// ---------- Attendance ----------
sig Attendance {
    student: one Student,
    course: one Course,
    status: one Status
}

// ---------- Status Enumeration ----------
enum Status {
    Present, Absent
}

// =====================================
// FACTS (Constraints)
// =====================================

// Unique Student ID constraint
fact UniqueStudentID {
    all s1, s2: Student |
        (s1 != s2) implies (s1.id != s2.id)
}

// Unique Course Code constraint
fact UniqueCourseCode {
    all c1, c2: Course |
        (c1 != c2) implies (c1.code != c2.code)
}

// Valid Attendance mapping constraint
fact ValidAttendanceRelation {
    all a: Attendance |
        a.student in Student and
        a.course in Course
}

// No duplicate attendance for same student-course pair
fact NoDuplicateAttendance {
    all a1, a2: Attendance |
        (a1 != a2 and a1.student = a2.student and a1.course = a2.course)
        implies a1.status != a2.status
}

// =====================================
// ASSERTIONS (Verification Checks)
// =====================================

// Check: Attendance always valid
assert AttendanceValidity {
    all a: Attendance |
        a.student in Student and a.course in Course
}

// Check: Students always unique
assert StudentsUnique {
    all s1, s2: Student |
        (s1 != s2) implies (s1.id != s2.id)
}

// Check: Courses always unique
assert CoursesUnique {
    all c1, c2: Course |
        (c1 != c2) implies (c1.code != c2.code)
}

// =====================================
// CHECK COMMANDS
// =====================================

check AttendanceValidity
check StudentsUnique
check CoursesUnique

// =====================================
// SAMPLE PREDICATE (for Run in Alloy)
// =====================================

pred showExample {
    some Student
    some Course
    some Attendance
}

run showExample for 5
