CREATE TABLE Student (
    student_id   INT PRIMARY KEY,
    first_name   VARCHAR(50),
    last_name    VARCHAR(50),
    email        VARCHAR(100),
    enroll_date  DATE
);

DELIMITER //

CREATE PROCEDURE add_student(
    IN p_student_id  INT,
    IN p_first_name  VARCHAR(50),
    IN p_last_name   VARCHAR(50),
    IN p_email       VARCHAR(100),
    IN p_enroll_date DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SELECT CONCAT('Error: Student ID ', p_student_id, ' already exists.') AS Message;
    END;

    INSERT INTO Student(
        student_id,
        first_name,
        last_name,
        email,
        enroll_date
    ) VALUES (
        p_student_id,
        p_first_name,
        p_last_name,
        p_email,
        IFNULL(p_enroll_date, CURDATE())
    );

    SELECT CONCAT('Student record inserted successfully for ID: ', p_student_id) AS Message;

END //

DELIMITER ;

CALL add_student(101, 'John', 'Doe', 'john.doe@example.com', '2026-09-23');
CALL add_student(102, 'Karthik', 'Raja', 'karthik.raja@example.com', NULL);

SELECT * FROM Student;
