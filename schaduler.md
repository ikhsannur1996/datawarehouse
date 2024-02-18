# Task Scheduling in Windows Task Scheduler

## Introduction
Windows Task Scheduler is a built-in feature in the Windows operating system that allows users to schedule tasks or scripts to run at specified intervals or events. This documentation provides a guide on how to schedule tasks using Windows Task Scheduler, focusing on scheduling batch files.

## Prerequisites
- Access to a Windows-based computer.
- Basic understanding of batch scripting.
- Permission to access and modify Windows Task Scheduler settings.

## Steps to Schedule a Batch File

### 1. Open Windows Task Scheduler
   - Press `Win + R` to open the Run dialog.
   - Type `taskschd.msc` and press Enter.

### 2. Create a New Task
   - In the Task Scheduler window, navigate to `Action` in the top menu.
   - Click on `Create Task...`.

### 3. General Settings
   - In the General tab:
     - Enter a name for your task.
     - Optionally, provide a description.
     - Ensure the task is set to run whether the user is logged on or not.
     - Choose appropriate privileges (usually highest privileges).
     - Set the desired compatibility options.

### 4. Triggers
   - In the Triggers tab:
     - Click on `New...` to create a new trigger.
     - Choose the schedule type (One time, Daily, Weekly, Monthly, etc.).
     - Set the start date and time.
     - Configure additional settings based on your requirements.

### 5. Actions
   - In the Actions tab:
     - Click on `New...` to create a new action.
     - Select `Start a program`.
     - Browse and select your batch file.
     - Optionally, set additional parameters.

### 6. Conditions and Settings (Optional)
   - Configure conditions and settings in respective tabs based on your requirements.
   - Adjust settings like power, idle, network, etc., as needed.

### 7. Save and Exit
   - After configuring all necessary settings, click `OK` to save the task.

## Example: Scheduling a Batch File
Suppose you have a batch file named `sales.bat` located at `C:\Users\user\Documents\Store Procedure\`.

### Batch File Content (sales.bat)
```batch
@echo off
SET PGPASSWORD=postgres
psql -U postgres -d postgres -f "C:\Users\user\Documents\Store Procedure\sp_sales.sql"
```

### SQL Procedure File (sp_sales.sql)
```sql
CALL dwh.generate_dwh();
```

## Conclusion
Windows Task Scheduler provides a convenient way to automate tasks, such as running batch files, at specific times or events. By following the steps outlined in this guide, users can effectively schedule tasks using Task Scheduler, improving efficiency and productivity.
