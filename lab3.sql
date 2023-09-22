SET LINESIZE 120
SET PAGESIZE 80
SET ECHO ON
SPOOL "C:\Users\Melody\Desktop\sad++\3\db2\lab3\Output.out"


-- Create constants for hard-coded values
DECLARE
  PRESIDENT CONSTANT NUMBER(7, 2) := 5000;
  REDUCTION CONSTANT NUMBER(3, 2) := 0.25;
  MIN_SALARY CONSTANT NUMBER(7, 2) := 100;
  SALARY_INCREASE CONSTANT NUMBER(3, 2) := 0.10;
  
  -- Variables for calculations
  avg_salary NUMBER(7, 2);
BEGIN
  -- Calculate the average salary after applying Rule 1
  SELECT AVG(CASE WHEN SAL > PRESIDENT THEN PRESIDENT * REDUCTION ELSE SAL END) INTO avg_salary FROM EMP;

  -- Update salaries based on Rule 1
  UPDATE EMP
  SET SAL = CASE WHEN SAL > PRESIDENT THEN PRESIDENT * REDUCTION ELSE SAL END
  WHERE EMPNO != 7839; -- Exclude the president
  
  -- Update salaries based on Rule 2
  UPDATE EMP
  SET SAL = SAL * (1 + SALARY_INCREASE)
  WHERE SAL < MIN_SALARY AND avg_salary > SAL;

  -- Display president's salary and average salary
  DBMS_OUTPUT.PUT_LINE('President''s Salary: ' || PRESIDENT);
  DBMS_OUTPUT.PUT_LINE('Average Salary: ' || avg_salary);
  
  COMMIT;
END;
/

SPOOL OFF
