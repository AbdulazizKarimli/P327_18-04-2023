CREATE VIEW Student_info
AS
SELECT s.Name ,s.Surname , g.No, e.StartDate , e.EndDate , su.Name 'Subject Name',st.Point FROM StudentExams  st
JOIN Students s
ON s.Id = st.StudentId
JOIN Groups g
ON g.Id = s.GroupId
JOIN Exams e
ON e.Id = st.ExamId
JOIN Subjects su
ON su.Id = e.SubjectId



SELECT COUNT(*) FROM Student_info
WHERE Point>=60 AND No = 'P327'

--Procedure
CREATE PROCEDURE usp_get_students_by_point @point int
AS
BEGIN
	SELECT * FROM Student_info
	WHERE Point>=@point
END

CREATE PROCEDURE usp_get_students_by_point_group @groupNo nvarchar(5), @point int = 51
AS
BEGIN
	SELECT * FROM Student_info
	WHERE Point>=@point AND No=@groupNo
END

EXEC usp_get_students_by_point 50

EXEC usp_get_students_by_point_group 'P327', 65

--Function
CREATE FUNCTION getStudentsCountByPoint(@groupNo nvarchar(5), @point int)
RETURNS int
BEGIN
	DECLARE @result int
	SELECT @result=COUNT(*) FROM Student_info
	WHERE Point>=@point AND No =@groupNo

	RETURN @result
END

SELECT dbo.getStudentsCountByPoint('P327', 65)

--Triggers
INSERT INTO Students
VALUES ('Togrul', 'Hezizade', 21, 2)

SELECT * FROM Students

CREATE TRIGGER select_after_insert
ON Students
AFTER INSERT
AS
BEGIN
	SELECT * FROM Students
END