@echo off
echo ========================================
echo    Foodie - Food Delivery App Setup
echo ========================================
echo.

rem ========================================
rem  STEP 1: Check Prerequisites
rem ========================================
echo [1/5] Checking prerequisites...

where mvn >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Maven is not installed! Install Maven 3.9+ and try again.
    pause
    exit /b 1
)
echo   [OK] Maven found

where java >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Java is not installed! Install JDK 17+ and try again.
    pause
    exit /b 1
)
echo   [OK] Java found

rem ========================================
rem  STEP 2: Setup MySQL Database
rem ========================================
echo.
echo [2/5] Setting up MySQL database...

echo   The app needs MySQL running on localhost:3306
echo   Default credentials: root / root
echo.
echo   Make sure your MySQL80 service is running!
echo   If using different credentials, edit:
echo     ^> DBConnection.java (lines 8-18)
echo.

set /p SETUP_DB=Do you want to set up the database now? (Y/N): 
if /i "%SETUP_DB%"=="Y" (
    echo   Creating database and tables...
    
    echo   Please enter your MySQL root password (default: root):
    set /p MYSQL_PASS=
    
    if "%MYSQL_PASS%"=="" set MYSQL_PASS=root
    
    REM Create the database
    echo create database if not exists food_delivery_application; | mysql -u root -p%MYSQL_PASS% 2>nul
    
    if %ERRORLEVEL% NEQ 0 (
        echo   [WARN] Could not connect to MySQL. Please run database-init.sql manually.
        echo   Using MySQL Workbench or command:
        echo     ^> mysql -u root -p ^< database-init.sql
    ) else (
        echo   Importing schema and sample data...
        mysql -u root -p%MYSQL_PASS% food_delivery_application < database-init.sql
        if %ERRORLEVEL% EQU 0 (
            echo   [OK] Database setup complete!
        ) else (
            echo   [WARN] Database import had issues. Try manual import.
        )
    )
) else (
    echo   [SKIP] Skipping database setup.
    echo   Remember to run database-init.sql manually!
)

rem ========================================
rem  STEP 3: Build the Application
rem ========================================
echo.
echo [3/5] Building the application...
echo   Running: mvn clean package

call mvn clean package
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Build failed! Check the error messages above.
    pause
    exit /b 1
)
echo   [OK] Build successful!

rem ========================================
rem  STEP 4: Check Tomcat
rem ========================================
echo.
echo [4/5] Checking Tomcat deployment...

echo.
echo   To deploy the app, copy the WAR file to your Tomcat webapps folder:
echo.
echo     copy target\fooddeliveryapp.war C:\path\to\tomcat\webapps\ROOT.war
echo.
echo   Then start Tomcat and visit:
echo     http://localhost:8080/home.jsp
echo.
echo   OR use the embedded Maven Tomcat plugin (if configured).

rem ========================================
rem  STEP 5: Start the App
rem ========================================
echo [5/5] Ready!
echo.
echo ========================================
echo    Setup Complete!
echo ========================================
echo.
echo   Quick Start Options:
echo   --------------------
echo   1. Deploy to existing Tomcat:
echo        copy target\fooddeliveryapp.war ^<TOMCAT_HOME^>\webapps\ROOT.war
echo.
echo   2. Install Docker and use:
echo        docker compose up -d
echo.
echo   3. Open your browser and go to:
echo        http://localhost:8080/home.jsp
echo.
echo   Sample credentials:
echo     Register a new account via register.jsp
echo.

pause
