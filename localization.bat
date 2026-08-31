@echo off
chcp 65001 > nul
echo =========================================
echo 開始執行自動化處理流程...
echo =========================================

:: 1. 複製 colours 資料夾內的所有檔案
echo [1/4] 正在複製 colours 資料夾裡的所有檔案...
if not exist "..\localization\colours" mkdir "..\localization\colours"
copy ".\colours\*" "..\localization\colours\" /Y

:: 2. 複製 xml 檔案至目標資料夾
echo [2/4] 正在複製 lsi.string_table.xml ...
copy ".\localization\lsi.string_table.xml" "..\localization\localization\" /Y

if %errorlevel% neq 0 (
    echo [錯誤] XML 檔案複製失敗，請確認路徑是否正確！
    pause
    exit /b %errorlevel%
)

:: 3. 切換目錄並執行 localization.bat (同視窗默默執行，絕不跳窗)
echo [3/4] 正在執行 localization.bat ...
pushd "..\localization\localization"
call "localization.bat"
popd

:: 4. 將產生的 .loc2 檔案複製回原目錄並加上 lsi_ 前綴
echo [4/4] 正在複製 .loc2 檔案並加上 3792884366_ 前綴...
for %%F in ("..\localization\localization\*.loc2") do (
    echo 複製: %%~nxF -^> 3792884366_%%~nxF
    copy "%%F" ".\localization\3792884366_%%~nxF" /Y
)

echo =========================================
echo 所有作業已完成！
echo =========================================
