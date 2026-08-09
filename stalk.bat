@echo off
chcp 65001 >nul
title NULL // LAST SIGNAL
mode con cols=100 lines=30
color 07
setlocal EnableDelayedExpansion

:: =========================================================
:: НАСТРОЙКИ
:: =========================================================

:: СЮДА ПОТОМ ВСТАВИШЬ ССЫЛКУ НА СВОЮ 3D-ИГРУ
set "GAME_URL=https://github.com/dimonndesshark/liminal-hell"

:: =========================================================
:: ПЕРЕМЕННЫЕ
:: =========================================================

set "hp=100"
set "ammo=6"
set "medkits=2"
set "keys=0"
set "clues=0"
set "chapter=1"

cls
goto boot


:: =========================================================
:: ЗАПУСК
:: =========================================================

:boot
cls
echo.
echo  ================================================================
echo.
echo                         N U L L
echo.
echo                       LAST SIGNAL
echo.
echo  ================================================================
echo.
echo  INITIALIZING...
timeout /t 1 >nul
echo  MEMORY............. OK
timeout /t 1 >nul
echo  NETWORK............ FAILED
timeout /t 1 >nul
echo  SIGNAL............. UNKNOWN
timeout /t 1 >nul
echo.
echo  [!] НЕИЗВЕСТНЫЙ СИГНАЛ ОБНАРУЖЕН
timeout /t 2 >nul

cls
echo.
echo  Ты просыпаешься в темноте.
echo.
echo  Вокруг нет света.
echo  Нет людей.
echo  Нет связи.
echo.
echo  Перед тобой работает старый терминал.
echo.
echo  На экране написано:
echo.
echo        "НЕ ДОВЕРЯЙ ТОМУ, ЧТО ВИДИШЬ."
echo.
pause
goto room1


:: =========================================================
:: КОМНАТА 1
:: =========================================================

:room1
cls
echo.
echo  ================================================================
echo                         УРОВЕНЬ 01
echo                         ПОДЗЕМЕЛЬЕ
echo  ================================================================
echo.
echo  Ты находишься в старом техническом помещении.
echo.
echo  В комнате есть:
echo.
echo  [1] Старый компьютер
echo  [2] Металлическая дверь
echo  [3] Шкаф
echo  [4] Осмотреть помещение
echo.
set /p choice=^> 

if "%choice%"=="1" goto computer
if "%choice%"=="2" goto door1
if "%choice%"=="3" goto cabinet
if "%choice%"=="4" goto search1

goto room1


:computer
cls
echo.
echo  КОМПЬЮТЕР
echo.
echo  Экран включается.
echo.
echo  > ACCESS TERMINAL
echo.
echo  Для доступа требуется код.
echo.
echo  На корпусе написано:
echo.
echo       2  -  6  -  12  -  20  -  30  -  ?
echo.
set /p answer=Код: 

if "%answer%"=="42" goto computer_ok

echo.
echo  ACCESS DENIED.
pause
goto computer


:computer_ok
set /a clues+=1
echo.
echo  ACCESS GRANTED.
echo.
echo  На экране появляется сообщение:
echo.
echo       "ПЕРВЫЙ ШАГ СДЕЛАН."
echo.
echo  Ты находишь старую карту.
echo.
pause
goto room1


:cabinet
cls
echo.
echo  ШКАФ
echo.
echo  Внутри:
echo.
echo  - старая аптечка
echo  - патроны
echo  - странная записка
echo.
echo  Ты забираешь предметы.
set /a medkits+=1
set /a ammo+=3
set /a clues+=1
echo.
echo  На записке:
echo.
echo  "Когда услышишь три удара —
echo   не открывай дверь сразу."
echo.
pause
goto room1


:search1
cls
echo.
echo  Ты осматриваешь помещение.
echo.
echo  На стене видны царапины.
echo.
echo  Кто-то написал:
echo.
echo              237
echo.
echo  Ниже:
echo.
echo              03:17
echo.
echo  Ты запоминаешь числа.
set /a clues+=1
pause
goto room1


:door1
cls
echo.
echo  Ты подходишь к металлической двери.
echo.
echo  Три удара.
echo.
timeout /t 1 >nul
echo  ТУК...
timeout /t 1 >nul
echo  ТУК...
timeout /t 1 >nul
echo  ТУК...
echo.
echo  Дверь начинает открываться сама.
echo.
echo  В коридоре что-то движется.
echo.
choice /c 12 /n /m "[1] Выйти  [2] Остаться: "

if errorlevel 2 goto room1
if errorlevel 1 goto corridor


:: =========================================================
:: КОРИДОР
:: =========================================================

:corridor
cls
echo.
echo  ================================================================
echo                         УРОВЕНЬ 02
echo                           КОРИДОР
echo  ================================================================
echo.
echo  Ты идёшь по тёмному коридору.
echo.
echo  Свет мигает.
echo.
echo  Впереди слышится звук.
echo.
echo  Что-то идёт за тобой.
echo.
pause
goto enemy1


:: =========================================================
:: ПЕРВЫЙ БОЙ
:: =========================================================

:enemy1
cls
echo.
echo  ================================================================
echo                          КОНТАКТ
echo  ================================================================
echo.
echo  HP: %hp%
echo  ПАТРОНЫ: %ammo%
echo.
echo  Существо приближается.
echo.
echo  [1] Стрелять
echo  [2] Бежать
echo  [3] Аптечка
echo.
set /p action=^> 

if "%action%"=="1" goto shoot1
if "%action%"=="2" goto run1
if "%action%"=="3" goto heal1

goto enemy1


:shoot1
if %ammo% LEQ 0 goto noammo

set /a ammo-=1
set /a enemyhp=enemyhp-40 2>nul

if not defined enemyhp set /a enemyhp=60

echo.
echo  ВЫСТРЕЛ.
timeout /t 1 >nul

if %enemyhp% LEQ 0 goto enemy1dead

set /a hp-=15

echo  Существо атакует.
echo  HP: %hp%
pause

if %hp% LEQ 0 goto death

goto enemy1


:noammo
echo.
echo  ПАТРОНОВ НЕТ.
pause
goto enemy1


:run1
echo.
echo  Ты бежишь.
echo.
timeout /t 2 >nul
echo  Дверь захлопывается.
echo.
set /a clues+=1
pause
goto level2


:heal1
if %medkits% LEQ 0 (
echo.
echo  Аптечек нет.
pause
goto enemy1
)

set /a medkits-=1
set /a hp+=35

if %hp% GTR 100 set hp=100

echo.
echo  HP восстановлено.
pause
goto enemy1


:enemy1dead
echo.
echo  Существо исчезает в темноте.
echo.
echo  Ты находишь ключ.
set /a keys+=1
set /a clues+=1
pause
goto level2


:: =========================================================
:: УРОВЕНЬ 2
:: =========================================================

:level2
cls
echo.
echo  ================================================================
echo                         УРОВЕНЬ 03
echo                         АРХИВ
echo  ================================================================
echo.
echo  Ты находишь огромную комнату с полками.
echo.
echo  На столе лежат четыре карточки:
echo.
echo       03:17
echo       07:44
echo       11:11
echo       19:28
echo.
echo  На стене:
echo.
echo  "ОДНО ИЗ ЭТИХ ВРЕМЁН НЕ ТАКОЕ, КАК ОСТАЛЬНЫЕ."
echo.
set /p answer=Ответ: 

if /i "%answer%"=="11:11" goto archive_ok

echo.
echo  Неверно.
echo.
pause
goto level2


:archive_ok
set /a clues+=1
echo.
echo  Правильно.
echo.
echo  За полкой открывается тайник.
echo.
echo  Внутри записка:
echo.
echo  "БЕЛАЯ КОМНАТА ЖДЁТ."
echo.
pause
goto level3


:: =========================================================
:: УРОВЕНЬ 3
:: =========================================================

:level3
cls
echo.
echo  ================================================================
echo                         УРОВЕНЬ 04
echo                       БЕЛАЯ КОМНАТА
echo  ================================================================
echo.
echo  Всё вокруг белое.
echo.
echo  Нет дверей.
echo  Нет окон.
echo  Нет теней.
echo.
echo  На стене появляется текст:
echo.
echo       "Я ВСЕГДА ВПЕРЕДИ ТЕБЯ."
echo       "НО ТЫ НИКОГДА НЕ МОЖЕШЬ МЕНЯ ДОГНАТЬ."
echo.
echo       "ЧТО Я?"
echo.
set /p answer=Ответ: 

if /i "%answer%"=="БУДУЩЕЕ" goto white_ok
if /i "%answer%"=="FUTURE" goto white_ok

echo.
echo  Комната становится темнее.
pause
goto level3


:white_ok
set /a clues+=1
echo.
echo  Правильно.
echo.
echo  Белая стена исчезает.
echo.
echo  За ней находится последний терминал.
pause
goto terminal


:: =========================================================
:: ФИНАЛЬНЫЙ ТЕРМИНАЛ
:: =========================================================

:terminal
cls
echo.
echo  ================================================================
echo                         NULL TERMINAL
echo  ================================================================
echo.
echo  Система распознаёт найденные данные.
echo.
echo  ЗАПИСКИ: %clues%
echo  HP: %hp%
echo  ПАТРОНЫ: %ammo%
echo  КЛЮЧИ: %keys%
echo.
echo  ================================================================
echo.
echo  Последний файл:
echo.
echo       NULL_PROTOCOL.exe
echo.
echo  Для запуска требуется финальный код.
echo.
set /p answer=Введи код: 

if /i "%answer%"=="%FINAL_CODE%" goto ending

echo.
echo  ACCESS DENIED.
echo.
echo  Система стирает часть данных.
set /a clues-=1
pause
goto terminal


:: =========================================================
:: ФИНАЛ
:: =========================================================

:ending
cls
color 0F

echo.
echo.
echo.
echo                 ==============================
echo.
echo                         ACCESS GRANTED
echo.
echo                 ==============================
echo.
echo.
echo              Ты действительно дошёл до конца.
echo.
echo              Но это был не конец.
echo.
echo              Ты нашёл NULL.
echo.
echo              Теперь найди:
echo.
echo                         NULL ACCESS
echo.
echo              Следующий уровень находится там.
echo.
echo              Подготовь код:
echo.
echo                         %FINAL_CODE%
echo.
echo.
echo  ================================================================
echo.
echo  Открыть следующий уровень?
echo.
choice /c 12 /n /m "[1] ДА  [2] НЕТ: "

if errorlevel 2 goto finish
if errorlevel 1 goto open_game


:: =========================================================
:: ОТКРЫТЬ 3D ИГРУ
:: =========================================================

:open_game
cls
echo.
echo  NULL ACCESS
echo.
echo  CONNECTION ESTABLISHED.
echo.
echo  Открытие следующего уровня...
timeout /t 2 >nul

start "" "%GAME_URL%"

goto finish


:death
cls
color 04

echo.
echo.
echo                  SIGNAL LOST
echo.
echo                  YOU ARE DEAD
echo.
echo.
pause

color 07
goto boot


:finish
cls
color 07

echo.
echo  ================================================================
echo.
echo                       CONNECTION CLOSED
echo.
echo  ================================================================
echo.
echo  Код сохранён в памяти.
echo.
pause
exit