@echo off
@title Ozank 718 Compiler Server
@echo Ozank 718 Compiler
"C:\Program Files\Java\jdk1.7.0_45\bin\javac.exe" -d bin -cp data/libs/*; -sourcepath src src/com/rs/game/player/Player.java
@echo Ozank 718 Compiler Part 1
"C:\Program Files\Java\jdk1.7.0_45\bin\javac.exe" -d bin -cp data/libs/*; -sourcepath src src/com/rs/game/player/Equipment.java
@echo Ozank 718 Compiler Part 2
"C:\Program Files\Java\jdk1.7.0_45\bin\javac.exe" -d bin -cp data/libs/*; -sourcepath src src/com/rs/Launcher.java
@echo Ozank 718 Compiler Part 3
"C:\Program Files\Java\jdk1.7.0_45\bin\javac.exe" -d bin -cp data/libs/*; -sourcepath src src/com/rs/game/player/dialogues/*.java
@echo Ozank 718 Compiler Part 4
"C:\Program Files\Java\jdk1.7.0_45\bin\javac.exe" -d bin -cp data/libs/*; -sourcepath src src/com/rs/*.java
@echo Ozank 718 Compiler Part 5
"C:\Program Files\Java\jdk1.7.0_45\bin\javac.exe" -d bin -cp data/libs/*; -sourcepath src src/com/rs/game/player/content/*.java
@echo Ozank 718 Compiler Part 6
"C:\Program Files\Java\jdk1.7.0_45\bin\javac.exe" -d bin -cp data/libs/*; -sourcepath src src/com/rs/net/decoders/handlers/*.java
@echo Done!
pause