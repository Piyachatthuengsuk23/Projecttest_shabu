@echo off
setlocal
if not exist results mkdir results
echo Running Robot tests (Windows)...
where python >nul 2>nul
if %ERRORLEVEL%==0 (
    python -m robot -d results tests
) else (
    where robot >nul 2>nul
    if %ERRORLEVEL%==0 (
        robot -d results tests
    ) else (
        echo ไม่พบ Python หรือ Robot ใน PATH กรุณาติดตั้งตามคู่มือใน README_th.md
        exit /b 1
    )
)
echo.
echo รายงานถูกสร้างที่โฟลเดอร์ results (report.html, log.html, output.xml)
endlocal
