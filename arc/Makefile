RM_RF:=rm -Rf
MKDIR_P:=mkdir -p
COPY:=cp
PYTHON3?=python
DOS2UNIX?=dos2unix

ROSE2ARC=./bin/rose2arc.py
VASM=./bin/vasmarm_std_win32.exe
VASM_OPTS:=-m250 -Fbin -opt-adr

ENGINE_DEPS:=engine/rose.asm engine/circles.asm engine/circledat.asm engine/engine.asm
COMMON_DEPS:=common/MemAlloc,ffa common/MMode98,ffa common/MMode97,ffa
MUSIC_DEPS:=common/QTM147,ffa

ARCULATOR_HOSTFS=../../../Arculator_V2.1_Windows/hostfs

##########################################################################
##########################################################################

# Ultimate goal:
# make all => build all Archie demo folders
# make cirlce => build circle demo folder

.PHONY:all
all: circle everyway waytoorude logicos technova euphoria

.PHONY:clean
clean:
	$(RM_RF) $(CIRCLE_BLD)
	$(RM_RF) $(EVERYWAY_BLD)
	$(RM_RF) $(WAYTOORUDE_BLD)
	$(RM_RF) $(LOGICOS_BLD)
	$(RM_RF) $(TECHNOVA_BLD)
	$(RM_RF) $(EUPHORIA_BLD)

##########################################################################
##########################################################################

CIRCLE_ARC=\!Circle
CIRCLE_SRC=examples/circle
CIRCLE_BLD=$(CIRCLE_SRC)/build
CIRCLE_DST=$(CIRCLE_BLD)/$(CIRCLE_ARC)

.PHONY:circle
circle: $(ARCULATOR_HOSTFS)/$(CIRCLE_ARC)

$(CIRCLE_SRC)/instructions.asm: $(CIRCLE_SRC)/bytecodes.bin $(CIRCLE_SRC)/constants.bin $(CIRCLE_SRC)/colorscript.bin $(ROSE2ARC)
	$(PYTHON3) $(ROSE2ARC) $(CIRCLE_SRC)/bytecodes.bin -c $(CIRCLE_SRC)/constants.bin -s $(CIRCLE_SRC)/colorscript.bin -o $(CIRCLE_SRC)/instructions.asm

$(CIRCLE_BLD)/circle.bin: $(CIRCLE_SRC)/instructions.asm $(ENGINE_DEPS)
	$(MKDIR_P) $(CIRCLE_BLD)
	$(VASM) -D_ENABLE_MUSIC=0 -D_FORM_WIDTH=352 -D_FORM_HEIGHT=280 -D_DUAL_PLAYFIELD=0 -D_SCREEN_MODE=98 -I../$(CIRCLE_SRC) $(VASM_OPTS) -L $(CIRCLE_BLD)/compile.txt -o $(CIRCLE_BLD)/circle.bin engine/rose.asm

$(CIRCLE_DST): $(CIRCLE_BLD)/circle.bin $(CIRCLE_BLD)/\!run.txt $(COMMON_DEPS)
	$(RM_RF) $(CIRCLE_DST)
	$(MKDIR_P) $(CIRCLE_DST)
	cp $(CIRCLE_BLD)/\!run.txt $(CIRCLE_DST)/\!Run,feb
	cp common/MemAlloc,ffa $(CIRCLE_DST)
	cp common/MMode98,ffa $(CIRCLE_DST)
	cp $(CIRCLE_BLD)/circle.bin $(CIRCLE_DST)/\!RunImage,ff8

$(CIRCLE_BLD)/\!run.txt: common/\!run_without_music.txt
	$(DOS2UNIX) -n common/\!run_without_music.txt $(CIRCLE_BLD)/\!run.txt

$(ARCULATOR_HOSTFS)/$(CIRCLE_ARC): $(CIRCLE_DST)
	$(RM_RF) $(ARCULATOR_HOSTFS)/$(CIRCLE_ARC)
	cp -r $(CIRCLE_DST) $(ARCULATOR_HOSTFS)/

##########################################################################
##########################################################################

EVERYWAY_ARC=\!Everyway
EVERYWAY_SRC=examples/everyway
EVERYWAY_BLD=$(EVERYWAY_SRC)/build
EVERYWAY_DST=$(EVERYWAY_BLD)/$(EVERYWAY_ARC)

.PHONY:everyway
everyway: $(ARCULATOR_HOSTFS)/$(EVERYWAY_ARC)

$(EVERYWAY_SRC)/instructions.asm: $(EVERYWAY_SRC)/bytecodes.bin $(EVERYWAY_SRC)/constants.bin $(EVERYWAY_SRC)/colorscript.bin $(ROSE2ARC)
	$(PYTHON3) $(ROSE2ARC) $(EVERYWAY_SRC)/bytecodes.bin -c $(EVERYWAY_SRC)/constants.bin -s $(EVERYWAY_SRC)/colorscript.bin -o $(EVERYWAY_SRC)/instructions.asm

$(EVERYWAY_BLD)/everyway.bin: $(EVERYWAY_SRC)/instructions.asm $(ENGINE_DEPS)
	$(MKDIR_P) $(EVERYWAY_BLD)
	$(VASM) -D_ENABLE_MUSIC=1 -D_FORM_WIDTH=352 -D_FORM_HEIGHT=280 -D_DUAL_PLAYFIELD=0 -DMAX_FRAMES=9000 -D_SCREEN_MODE=98 -I../$(EVERYWAY_SRC) $(VASM_OPTS) -L $(EVERYWAY_BLD)/compile.txt -o $(EVERYWAY_BLD)/everyway.bin engine/rose.asm

$(EVERYWAY_DST): $(EVERYWAY_BLD)/everyway.bin $(EVERYWAY_BLD)/\!run.txt $(EVERYWAY_SRC)/h0ffman_-_everyway.mod $(COMMON_DEPS) $(MUSIC_DEPS)
	$(RM_RF) $(EVERYWAY_DST)
	$(MKDIR_P) $(EVERYWAY_DST)
	cp $(EVERYWAY_BLD)/\!run.txt $(EVERYWAY_DST)/\!Run,feb
	cp common/MemAlloc,ffa $(EVERYWAY_DST)
	cp common/QTM147,ffa $(EVERYWAY_DST)
	cp common/MMode98,ffa $(EVERYWAY_DST)
	cp $(EVERYWAY_BLD)/everyway.bin $(EVERYWAY_DST)/\!RunImage,ff8
	cp $(EVERYWAY_SRC)/h0ffman_-_everyway.mod $(EVERYWAY_DST)/\Music,001

$(EVERYWAY_BLD)/\!run.txt: common/\!run_with_music_overscan.txt
	$(DOS2UNIX) -n common/\!run_with_music_overscan.txt $(EVERYWAY_BLD)/\!run.txt

$(ARCULATOR_HOSTFS)/$(EVERYWAY_ARC): $(EVERYWAY_DST)
	$(RM_RF) $(ARCULATOR_HOSTFS)/$(EVERYWAY_ARC)
	cp -r $(EVERYWAY_DST) $(ARCULATOR_HOSTFS)/

##########################################################################
##########################################################################

WAYTOORUDE_ARC=\!WayTooRude
WAYTOORUDE_SRC=examples/waytoorude
WAYTOORUDE_BLD=$(WAYTOORUDE_SRC)/build
WAYTOORUDE_DST=$(WAYTOORUDE_BLD)/$(WAYTOORUDE_ARC)

.PHONY:waytoorude
waytoorude: $(ARCULATOR_HOSTFS)/$(WAYTOORUDE_ARC)

$(WAYTOORUDE_SRC)/instructions.asm: $(WAYTOORUDE_SRC)/bytecodes.bin $(WAYTOORUDE_SRC)/constants.bin $(WAYTOORUDE_SRC)/colorscript.bin $(ROSE2ARC)
	$(PYTHON3) $(ROSE2ARC) $(WAYTOORUDE_SRC)/bytecodes.bin -c $(WAYTOORUDE_SRC)/constants.bin -s $(WAYTOORUDE_SRC)/colorscript.bin -o $(WAYTOORUDE_SRC)/instructions.asm

$(WAYTOORUDE_BLD)/waytoorude.bin: $(WAYTOORUDE_SRC)/instructions.asm $(ENGINE_DEPS)
	$(MKDIR_P) $(WAYTOORUDE_BLD)
	$(VASM) -D_ENABLE_MUSIC=1 -D_FORM_WIDTH=320 -D_FORM_HEIGHT=180 -D_DUAL_PLAYFIELD=1 -DMAX_FRAMES=13000 -D_SCREEN_MODE=97 -I../$(WAYTOORUDE_SRC) $(VASM_OPTS) -L $(WAYTOORUDE_BLD)/compile.txt -o $(WAYTOORUDE_BLD)/waytoorude.bin engine/rose.asm

$(WAYTOORUDE_DST): $(WAYTOORUDE_BLD)/waytoorude.bin $(WAYTOORUDE_BLD)/\!run.txt $(WAYTOORUDE_SRC)/way_too_rude.mod $(COMMON_DEPS) $(MUSIC_DEPS)
	$(RM_RF) $(WAYTOORUDE_DST)
	$(MKDIR_P) $(WAYTOORUDE_DST)
	cp $(WAYTOORUDE_BLD)/\!run.txt $(WAYTOORUDE_DST)/\!Run,feb
	cp common/MemAlloc,ffa $(WAYTOORUDE_DST)
	cp common/QTM147,ffa $(WAYTOORUDE_DST)
	cp common/MMode97,ffa $(WAYTOORUDE_DST)
	cp $(WAYTOORUDE_BLD)/waytoorude.bin $(WAYTOORUDE_DST)/\!RunImage,ff8
	cp $(WAYTOORUDE_SRC)/way_too_rude.mod $(WAYTOORUDE_DST)/\Music,001

$(WAYTOORUDE_BLD)/\!run.txt: common/\!run_with_music.txt
	$(DOS2UNIX) -n common/\!run_with_music_widescreen.txt $(WAYTOORUDE_BLD)/\!run.txt

$(ARCULATOR_HOSTFS)/$(WAYTOORUDE_ARC): $(WAYTOORUDE_DST)
	$(RM_RF) $(ARCULATOR_HOSTFS)/$(WAYTOORUDE_ARC)
	cp -r $(WAYTOORUDE_DST) $(ARCULATOR_HOSTFS)/

##########################################################################
##########################################################################

LOGICOS_ARC=\!LogicOS
LOGICOS_SRC=examples/logicos
LOGICOS_BLD=$(LOGICOS_SRC)/build
LOGICOS_DST=$(LOGICOS_BLD)/$(LOGICOS_ARC)

.PHONY:logicos
logicos: $(ARCULATOR_HOSTFS)/$(LOGICOS_ARC)

$(LOGICOS_SRC)/instructions.asm: $(LOGICOS_SRC)/bytecodes.bin $(LOGICOS_SRC)/constants.bin $(LOGICOS_SRC)/colorscript.bin $(ROSE2ARC)
	$(PYTHON3) $(ROSE2ARC) $(LOGICOS_SRC)/bytecodes.bin -c $(LOGICOS_SRC)/constants.bin -s $(LOGICOS_SRC)/colorscript.bin -o $(LOGICOS_SRC)/instructions.asm

$(LOGICOS_BLD)/logicos.bin: $(LOGICOS_SRC)/instructions.asm $(ENGINE_DEPS)
	$(MKDIR_P) $(LOGICOS_BLD)
	$(VASM) -D_ENABLE_MUSIC=1 -D_FORM_WIDTH=320 -D_FORM_HEIGHT=180 -D_DUAL_PLAYFIELD=1 -DMAX_FRAMES=14000 -D_SCREEN_MODE=97 -DMAX_STACK=31 -I../$(LOGICOS_SRC) $(VASM_OPTS) -L $(LOGICOS_BLD)/compile.txt -o $(LOGICOS_BLD)/logicos.bin engine/rose.asm

$(LOGICOS_DST): $(LOGICOS_BLD)/logicos.bin $(LOGICOS_BLD)/\!run.txt $(LOGICOS_SRC)/logicos.mod $(COMMON_DEPS) $(MUSIC_DEPS)
	$(RM_RF) $(LOGICOS_DST)
	$(MKDIR_P) $(LOGICOS_DST)
	cp $(LOGICOS_BLD)/\!run.txt $(LOGICOS_DST)/\!Run,feb
	cp common/MemAlloc,ffa $(LOGICOS_DST)
	cp common/QTM147,ffa $(LOGICOS_DST)
	cp common/MMode97,ffa $(LOGICOS_DST)
	cp $(LOGICOS_BLD)/logicos.bin $(LOGICOS_DST)/\!RunImage,ff8
	cp $(LOGICOS_SRC)/logicos.mod $(LOGICOS_DST)/\Music,001

$(LOGICOS_BLD)/\!run.txt: common/\!run_with_large_ram.txt
	$(DOS2UNIX) -n common/\!run_with_large_ram.txt $(LOGICOS_BLD)/\!run.txt

$(ARCULATOR_HOSTFS)/$(LOGICOS_ARC): $(LOGICOS_DST)
	$(RM_RF) $(ARCULATOR_HOSTFS)/$(LOGICOS_ARC)
	cp -r $(LOGICOS_DST) $(ARCULATOR_HOSTFS)/

##########################################################################
##########################################################################

TECHNOVA_ARC=\!TechNova
TECHNOVA_SRC=examples/technova
TECHNOVA_BLD=$(TECHNOVA_SRC)/build
TECHNOVA_DST=$(TECHNOVA_BLD)/$(TECHNOVA_ARC)

.PHONY:technova
technova: $(ARCULATOR_HOSTFS)/$(TECHNOVA_ARC)

$(TECHNOVA_SRC)/instructions.asm: $(TECHNOVA_SRC)/bytecodes.bin $(TECHNOVA_SRC)/constants.bin $(TECHNOVA_SRC)/colorscript.bin $(ROSE2ARC)
	$(PYTHON3) $(ROSE2ARC) $(TECHNOVA_SRC)/bytecodes.bin -c $(TECHNOVA_SRC)/constants.bin -s $(TECHNOVA_SRC)/colorscript.bin -o $(TECHNOVA_SRC)/instructions.asm

$(TECHNOVA_BLD)/technova.bin: $(TECHNOVA_SRC)/instructions.asm $(ENGINE_DEPS)
	$(MKDIR_P) $(TECHNOVA_BLD)
	$(VASM) -D_ENABLE_MUSIC=1 -D_FORM_WIDTH=320 -D_FORM_HEIGHT=180 -D_DUAL_PLAYFIELD=1 -DMAX_FRAMES=8000 -D_SCREEN_MODE=97 -I../$(TECHNOVA_SRC) $(VASM_OPTS) -L $(TECHNOVA_BLD)/compile.txt -o $(TECHNOVA_BLD)/technova.bin engine/rose.asm

$(TECHNOVA_DST): $(TECHNOVA_BLD)/technova.bin $(TECHNOVA_BLD)/\!run.txt $(TECHNOVA_SRC)/h0ffman_-_technova.mod $(COMMON_DEPS) $(MUSIC_DEPS)
	$(RM_RF) $(TECHNOVA_DST)
	$(MKDIR_P) $(TECHNOVA_DST)
	cp $(TECHNOVA_BLD)/\!run.txt $(TECHNOVA_DST)/\!Run,feb
	cp common/MemAlloc,ffa $(TECHNOVA_DST)
	cp common/QTM147,ffa $(TECHNOVA_DST)
	cp common/MMode97,ffa $(TECHNOVA_DST)
	cp $(TECHNOVA_BLD)/technova.bin $(TECHNOVA_DST)/\!RunImage,ff8
	cp $(TECHNOVA_SRC)/h0ffman_-_technova.mod $(TECHNOVA_DST)/\Music,001

$(TECHNOVA_BLD)/\!run.txt: common/\!run_with_music_widescreen.txt
	$(DOS2UNIX) -n common/\!run_with_music.txt $(TECHNOVA_BLD)/\!run.txt

$(ARCULATOR_HOSTFS)/$(TECHNOVA_ARC): $(TECHNOVA_DST)
	$(RM_RF) $(ARCULATOR_HOSTFS)/$(TECHNOVA_ARC)
	cp -r $(TECHNOVA_DST) $(ARCULATOR_HOSTFS)/

##########################################################################
##########################################################################

EUPHORIA_ARC=\!Euphoria
EUPHORIA_SRC=examples/euphoria
EUPHORIA_BLD=$(EUPHORIA_SRC)/build
EUPHORIA_DST=$(EUPHORIA_BLD)/$(EUPHORIA_ARC)

.PHONY:euphoria
euphoria: $(ARCULATOR_HOSTFS)/$(EUPHORIA_ARC)

$(EUPHORIA_SRC)/instructions.asm: $(EUPHORIA_SRC)/bytecodes.bin $(EUPHORIA_SRC)/constants.bin $(EUPHORIA_SRC)/colorscript.bin $(ROSE2ARC)
	$(PYTHON3) $(ROSE2ARC) $(EUPHORIA_SRC)/bytecodes.bin -c $(EUPHORIA_SRC)/constants.bin -s $(EUPHORIA_SRC)/colorscript.bin -o $(EUPHORIA_SRC)/instructions.asm

$(EUPHORIA_BLD)/euphoria.bin: $(EUPHORIA_SRC)/instructions.asm $(ENGINE_DEPS)
	$(MKDIR_P) $(EUPHORIA_BLD)
	$(VASM) -D_ENABLE_MUSIC=1 -D_FORM_WIDTH=352 -D_FORM_HEIGHT=280 -D_DUAL_PLAYFIELD=0 -DMAX_FRAMES=7400 -D_SCREEN_MODE=98 -I../$(EUPHORIA_SRC) $(VASM_OPTS) -L $(EUPHORIA_BLD)/compile.txt -o $(EUPHORIA_BLD)/euphoria.bin engine/rose.asm

$(EUPHORIA_DST): $(EUPHORIA_BLD)/euphoria.bin $(EUPHORIA_BLD)/\!run.txt $(EUPHORIA_SRC)/painters\ euphoria.mod $(COMMON_DEPS) $(MUSIC_DEPS)
	$(RM_RF) $(EUPHORIA_DST)
	$(MKDIR_P) $(EUPHORIA_DST)
	cp $(EUPHORIA_BLD)/\!run.txt $(EUPHORIA_DST)/\!Run,feb
	cp common/MemAlloc,ffa $(EUPHORIA_DST)
	cp common/MMode98,ffa $(EUPHORIA_DST)
	cp common/QTM147,ffa $(EUPHORIA_DST)
	cp $(EUPHORIA_BLD)/euphoria.bin $(EUPHORIA_DST)/\!RunImage,ff8
	cp $(EUPHORIA_SRC)/painters\ euphoria.mod $(EUPHORIA_DST)/\Music,001

$(EUPHORIA_BLD)/\!run.txt: common/\!run_with_music.txt
	$(DOS2UNIX) -n common/\!run_with_music.txt $(EUPHORIA_BLD)/\!run.txt

$(ARCULATOR_HOSTFS)/$(EUPHORIA_ARC): $(EUPHORIA_DST)
	$(RM_RF) $(ARCULATOR_HOSTFS)/$(EUPHORIA_ARC)
	cp -r $(EUPHORIA_DST) $(ARCULATOR_HOSTFS)/

##########################################################################
##########################################################################
