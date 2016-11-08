as
declare @EmpID int,@user varchar(20), @activity varchar(20);
if exists(SELECT * from inserted) and exists (SELECT * from deleted)
begin
    SET @activity = 'UPDATE';
    SET @user = SYSTEM_USER;
    SELECT @EmpID = EmployeeID from inserted i;
    INSERT into Emp_Audit(EmpID,Activity, DoneBy) values (@EmpID,@activity,@user);
end

If exists (Select * from inserted) and not exists(Select * from deleted)
begin
    SET @activity = 'INSERT';
    SET @user = SYSTEM_USER;
    SELECT @EmpID = EmployeeID from inserted i;
    INSERT into Emp_Audit(EmpID,Activity, DoneBy) values(@EmpID,@activity,@user);
end

If exists(select * from deleted) and not exists(Select * from inserted)
begin 
    SET @activity = 'DELETE';
    SET @user = SYSTEM_USER;
    SELECT @EmpID = EmployeeID from deleted i;
    INSERT into Emp_Audit(EmpID,Activity, DoneBy) values(@EmpID,@activity,@user);
end
