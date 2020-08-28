.PHONY = build clean

# Project variables
OUT_FILE = MyProject.rbxlx

# A few rojo variables
ROJO = rojo
ROJO_PROJECT_BUILD = default.project.json

# Here, you can add other dependencies built using make similar to Modules
DEPS = lib/Modules/Modules.rbxmx #\
       #lib/MyModule/MyModule.rbxmx

build : $(OUT_FILE)

$(OUT_FILE) : $(DEPS) $(shell find src -type f)
	$(ROJO) build $(ROJO_PROJECT_BUILD) --output $(OUT_FILE)

$(DEPS) : 
	$(MAKE) --directory=$(@D)

clean :
	$(RM) $(OUT_FILE)
