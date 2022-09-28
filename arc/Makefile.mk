ifeq ($(OS),Windows_NT)
RM_RF:=-cmd /c rd /s /q
MKDIR_P:=-cmd /c mkdir
COPY:=copy
PYTHON3?=python.exe
else
RM_RF:=rm -Rf
MKDIR_P:=mkdir -p
COPY:=cp
PYTHON3?=python
endif

ROSE2ARC=./bin/rose2arc.py

##########################################################################
##########################################################################
