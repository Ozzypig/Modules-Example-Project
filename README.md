# Blank Modules Project (Example)

This is an example of a [Rojo](https://github.com/Roblox/rojo)-powered project that uses [Modules](https://github.com/Ozzypig/Modules) as a dependency. Like Modules itself, this project also uses GNU make ([Makefile](Makefile)) to build the project easily.

## How the dependency works

Here's how _Modules_ is included in this project as a dependency:

1. The [Modules](https://github.com/Ozzypig/Modules) repository is added as git submodule.
2. The [Makefile](Makefile) is run by invoking `make`. It [recursively](https://www.gnu.org/software/make/manual/html_node/Recursion.html) invokes Modules' [Makefile](https://github.com/Ozzypig/Modules/blob/master/Makefile) to build `Modules.rbxmx`.
3. The file [default.project.json](default.project.json) is built using `rojo` from within the Makefile. It includes built `Modules.rbxmx` into ReplicatedStorage after Modules is built.

## Adding other dependencies

You could add other dependencies (even ones that use Modules itself) by following these steps. Your dependency needs to be created using `make` in order to work with the provided Makefile.

1. Add the git repository for your dependency as a git submodule (file path works too, but you probably should have it online):

    ```bash
    $ git submodule add https://github.com/You/MyLibrary lib/MyLibrary
    ```

2. Add the rbxmx file to the `$DEPS` variable in the [Makefile](Makefile) (hint: use `\` to go to the next line). `make` will be recursively invoked in the directory containing your dependency (below, `lib/MyLibrary`).

    ```
    DEPS = lib/Modules/Modules.rbxmx \
           lib/MyLibrary/MyLibrary.rbxmx
    ```

3. Include the dependency in your Rojo project via an [instance description](https://rojo.space/docs/0.5.x/reference/project-format/#instance-description) by pointing `$path` to the resulting rbxmx file (remember, this path is relative to the project file).

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
