#!/usr/bin/env python

# Default build file used
import os
import platform
import sys
import logging
import subprocess
import time
import shutil
import traceback

# configuration stuffs (change if you want to)
BUILD_OUTPUT_FOLDER_NAME = "Artifacts"
ALLOW_BUILD_LOG_TO_FILE = True
BUILD_LOG_FILE_NAME = (
    "onthefly_pybuilder.log"  # only is used if ALLOW_BUILD_LOG_TO_FILE is also True
)

# ephemeral constants (dont touch mostly)
logger = logging.getLogger("OnTheFly_PyBuilder")
release_build = False
target_platform = "windows"
ephemeral_build_root_folder = None
launcher_executable_name = "onthefly_launcher"


# build processing subroutines
def init_build_folder():
    logger.info("INIT_BUILD_FOLDER")
    try:
        os.makedirs(BUILD_OUTPUT_FOLDER_NAME)
        logger.info(f"BUILD_FOLDER @@ {BUILD_OUTPUT_FOLDER_NAME}")
    except FileExistsError:
        logger.warning("BUILD_FOLDER @@ Already exists, skipping...")
    except PermissionError:
        logger.error("BUILD_FOLDER @@ Permission error!")
    except Exception as e:
        logger.error(f"BUILD_FOLDER @@ Error occured while initting {e}")


def __run_cmd__(
    name: str,
    curr_dir: str,
    invokes: list[str],
    std_err: int = subprocess.STDOUT,
    std_out: int = subprocess.PIPE,
) -> int:
    logger.info(f"{name} @@ {curr_dir}")
    start_build_time: float = time.time()
    logger.info(f"{name} invoked at {time.ctime(start_build_time)}")
    build_context: subprocess.CompletedProcess[str] = subprocess.run(
        invokes,
        cwd=os.path.join(os.getcwd(), curr_dir),
        stderr=std_err,
        stdout=std_out,
        text=True,
    )
    # might need to finish some encoding issues with the output
    logger.info(
        f"{name} @@ TOOK: {time.time()-start_build_time} {curr_dir}\nOUTPUT [{build_context.returncode}]\n{build_context.stdout}"
    )
    return build_context.returncode


def run_make(curr_dir: str | None, invokes: list[str] | None = None) -> int:
    def_invoke: list[str] = ["make"]
    return __run_cmd__(
        "MAKE",
        curr_dir=curr_dir if curr_dir else ".",
        invokes=def_invoke if not invokes else def_invoke + invokes,
    )


def run_flutter_build(
    curr_dir: str | None = None, invokes: list[str] | None = None
) -> int:
    def_invokes: list[str] = [
        "flutter.bat",
        "build",
        target_platform,
        "--release" if release_build else "",
    ]
    return __run_cmd__(
        "FLUTTER_BUILD",
        curr_dir=curr_dir if curr_dir else ".",
        invokes=def_invokes if not invokes else def_invokes + invokes,
    )


def mv_cpyfolders(src: str, dest: str, force_move=False, cleanup=True):
    logger.info(f"MV_COPY_FOLDERS @@ {src} -> {dest}")
    logger.info(f"SRC_TREE -> {os.listdir(src)}")
    logger.info(f"DEST_TREE (ExpectBlank) -> {os.listdir(dest)}")
    if force_move:
        for f in os.listdir(src):
            shutil.move(os.path.join(src, f), dest)
    else:
        shutil.copytree(src, dest, symlinks=True, dirs_exist_ok=True)
    if cleanup:
        for f in os.listdir(src):
            if os.path.isfile(os.path.join(src, f)):
                os.remove(os.path.join(os.getcwd(), src, f))
            else:
                shutil.rmtree(os.path.join(src, f))
        logger.info(f"CLEANED UP {src}")


# actual routine processing goes here
if __name__ == "__main__":
    start_build_time = time.time()
    formatter = logging.Formatter(
        "%(asctime)s | %(name)s | %(levelname)s $ %(message)s"
    )
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.DEBUG)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    logger.setLevel(logging.DEBUG)
    release_build = any(arg == "--release" for arg in sys.argv)
    # TODO: might have support for other platforms later
    init_build_folder()
    if ALLOW_BUILD_LOG_TO_FILE:
        logger_path = os.path.join(BUILD_OUTPUT_FOLDER_NAME, BUILD_LOG_FILE_NAME)
        file_handler = logging.FileHandler(logger_path)
        open(logger_path, "w").close()
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(formatter)
        logger.addHandler(file_handler)
    target_platform = "windows"  # only supporting windows for now
    logger.info("============ BEGIN ============")
    logger.info(f"Build Started at {time.ctime(start_build_time)}")
    logger.info(f"System PATH: {os.environ['PATH']}")
    logger.info(f"RELEASE_BUILD={release_build}")
    ephemeral_build_root_folder = os.path.join(
        "build",
        target_platform,
        "x64",
        "runner",
        "Release" if release_build else "Debug",
    )
    logger.info(f"Build location @ {ephemeral_build_root_folder}")
    try:
        if (code := run_flutter_build()) != 0:
            raise RuntimeError(f"Flutter build returned output code {code}")
        else:
            logger.info("flutter_build OK")
    except Exception:
        logger.error(f"{traceback.format_exc()}")
    mv_cpyfolders(
        ephemeral_build_root_folder,
        os.path.join(BUILD_OUTPUT_FOLDER_NAME),
    )
    # section for building the launcher program
    logger.info("Start build for launcher")
    launcher_build_root_folder = os.path.join("launcher", "dist")
    try:
        if (
            code := run_make(
                "./launcher",
                invokes=[
                    "build_release",
                    f"o_name={launcher_executable_name}",
                ],
            )
        ) != 0:
            raise RuntimeError(f"Misconfigured launcher MAKE!!! {code}")
        else:
            logger.info("make [./launcher] OK")
    except Exception:
        logger.error(f"{traceback.format_exc()}")
    mv_cpyfolders(
        launcher_build_root_folder,
        os.path.join(BUILD_OUTPUT_FOLDER_NAME),
    )
    logger.info("============= END =============")
    end_build_time = time.time()
    logger.info(
        f"Build Ended at {time.ctime(end_build_time)}, took {end_build_time - start_build_time}s"
    )
