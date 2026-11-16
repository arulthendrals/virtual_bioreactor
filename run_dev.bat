@echo off
echo ========================================================
echo   FermentTwin - Development Mode (Vite + Flask)
echo ========================================================
echo.

cd /d "%~dp0backend"
start "FermentTwin Backend (Flask :5000)" python app.py

cd /d "%~dp0frontend"
start "FermentTwin Frontend (Vite :3000)" cmd /c "npm run dev"

timeout /t 3 >nul
start http://localhost:3000

echo FermentTwin Dev Environment started!
echo Frontend: http://localhost:3000
echo Backend API: http://127.0.0.1:5000
