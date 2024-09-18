# Aseprite compiler

Aseprite is a open source pixel art tool editor.
Since the compilation steps can be a bit complicated I decided to automate the process using docker.

## Updating docker-compose

In the docker-compose file there is declared two environment variables which are associated with Aseprite source and Skia source.

You can find the latest version of Aseprite source [here](https://github.com/aseprite/aseprite/releases).

And for Skia, you can find the lastest source [here](https://github.com/aseprite/skia/releases).

Replace the docker-compose urls with the proper link of the source .zip
Pay attention to which source you going to copy from Skia. We are using libc++ instead libc, since we are using clang to compile Aseprite instead GCC.

In case you want to read more about the compilation steps of Aseprite in other platforms such as windows and mac, you can find all details [here](https://github.com/aseprite/aseprite/blob/main/INSTALL.md).

The official repository of Aseprite can be accessed [here](https://github.com/aseprite/aseprite/).

## Compiling Aseprite

It is necessary to use make to perform the task of compilation.
You can check inside Makefile to see all different tasks.
There are two important tasks you probably more interested, install and reset.

    make install

The command above will handle everything for you. Once the tasks is done, you can see a folder called aseprite in the current directory, with the program compiled and ready to use.

    make reset

This command is useful in case you want to clean the current compiled version of aseprite and recompile or compile using new version with updated links declared in docker-compose.

## License

This automation scripts is distributed under GNU GENERAL PUBLIC LICENSE.
