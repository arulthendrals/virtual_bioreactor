@echo off
echo ========================================================
echo   FermentTwin - Virtual Fermentation Simulator
echo   Simulate. Analyze. Optimize.
echo ========================================================
echo.

cd /d "%~dp0backend"
echo [1/2] Starting FermentTwin Scientific Simulation Engine...
start "FermentTwin Backend" python app.py

echo.
echo [2/2] Opening FermentTwin in your default browser...
timeout /t 2 >nul
start http://127.0.0.1:5000

echo.
echo ========================================================
echo FermentTwin is online at http://127.0.0.1:5000
echo.
echo To run the React development server with HMR:
echo   cd frontend
echo   npm run dev
echo ========================================================
pause
