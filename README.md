# Modules Example Project

This is an example of a [Rojo](https://github.com/Roblox/rojo)-powered project that uses _[Modules](https://github.com/Ozzypig/Modules)_ as a dependency. Like _Modules_ itself, this project also uses GNU make ([Makefile](Makefile)) to build the project. Although it's not required, using `make` makes it easy.

## How the dependency works

Here's how _Modules_ is included in this project as a dependency:

1. The _[Modules](https://github.com/Ozzypig/Modules)_ repository is added as git submodule.
2. The `Modules.rbxmx` file is built first: the [Makefile](Makefile) is run by invoking `make`. It [recursively](https://www.gnu.org/software/make/manual/html_node/Recursion.html) invokes Modules' [Makefile](https://github.com/Ozzypig/Modules/blob/master/Makefile).
3. This project is built second: the file [default.project.json](default.project.json) is built using `rojo` from within the Makefile. It includes built `Modules.rbxmx` into ReplicatedStorage after Modules is built.

## Creating and adding other dependencies

### Setting up a dependency

You should first make your dependency into a git repository so it can be added as a submodule later. Assuming you put your code into a `src` directory, this simple Makefile like this should be useful:

```
OUT_FILE = MyLibrary.rbxmx
ROJO_PROJECT = default.project.json

$(OUT_FILE) : $(shell find src -type f)
	rojo build $(ROJO_PROJECT) --output $(OUT_FILE)
```

Note: the `$(shell find src -type f)` here specifies that the `OUT_FILE` depends on all files within the `src/` directory.

### Adding a dependancy

Once you have your dependency repository set up nicely, you can add it to this example project by following these steps.

1. Add the git repository for your dependency as a git submodule (file path works too, but you probably should have it online):

    ```bash
    $ git submodule add https://github.com/You/MyLibrary lib/MyLibrary
    ```

2. Add the rbxmx file to the `DEPS` variable in the [Makefile](Makefile) (hint: use `\` to use multiple lines). `make` will be recursively invoked in the directory containing your dependency (below, `lib/MyLibrary`).

    ```
    DEPS = lib/Modules/Modules.rbxmx \
           lib/MyLibrary/MyLibrary.rbxmx
    ```

3. Include the dependency in this example's Rojo project via an [instance description](https://rojo.space/docs/0.5.x/reference/project-format/#instance-description) by pointing `$path` to the resulting rbxmx file (remember, this path is relative to the project file).

    ```json
    {
        "name": "MyProject",
        "tree": {
            "$className": "DataModel",
            "ReplicatedStorage": {
                "$className": "ReplicatedStorage",
                "Modules": {
                    "$path": "lib/Modules/Modules.rbxmx"
                },
                "MyProject": {
                    "$path": "src/ReplicatedStorage"
                },
                "MyLibrary": {
                    "$path": "lib/MyLibrary/MyLibrary.rbxmx"
                }
            },
            "ServerScriptService": {
                "$className": "ServerScriptService",
                "MyProject": {
                    "$path": "src/ServerScriptService"
                }
            }
        }
    }
    ```
