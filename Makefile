# Rose has no top-level build: each target has its own, and none of them
# runs from PowerShell as-is (they use sh, rm, cp). See START_HERE.md.
.PHONY: all help
all: help

help:
	@echo Nothing to build at the top level of Rose. Builds live in the subfolders:
	@echo   visualizer\Makefile  - Windows C++ visualizer (needs GLFW/GLEW/PortAudio in ..\..\..\Libs, and sh)
	@echo   arc\Makefile         - Archimedes demos (uses rm/cp: run from Git Bash), copies to ..\..\arculator\hostfs
	@echo   bbc\nano\build.sh    - Rose Nano for the BBC Micro (Git Bash): bbc/nano/build.sh name
	@echo See START_HERE.md and CLAUDE.md
