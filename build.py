# Default build file used
import os
import sys
import logging
import subprocess
import time
import shutil
import traceback
import itertools

# configuration stuffs (change if you want to)
BUILD_OUTPUT_FOLDER_NAME = "BuildArtifacts"
BUILD_OUTPUT_FOLDER_ROOT_NAME = "OnTheFly"
BUILD_OUTPUT_FOLDER_UPDATER_NAME = "OnTheFly_Updater"
ALLOW_BUILD_LOG_TO_FILE = True
BUILD_LOG_FILE_NAME = (
    "onthefly_pybuilder.log"  # only is used if ALLOW_BUILD_LOG_TO_FILE is also True
)

# ephemeral constants (dont touch mostly)
logger = logging.getLogger("OnTheFly_PyBuilder")
release_build = False
target_platform = "windows"
await_spinner = itertools.cycle("-/|\\")
ephemeral_build_root_folder = None


# build processing subroutines
def init_build_folder():
    logger.info("INIT_BUILD_FOLDER")
    try:
        os.makedirs(
            os.path.join(BUILD_OUTPUT_FOLDER_NAME, BUILD_OUTPUT_FOLDER_ROOT_NAME)
        )
        os.mkdir(
            os.path.join(BUILD_OUTPUT_FOLDER_NAME, BUILD_OUTPUT_FOLDER_UPDATER_NAME)
        )
        logger.info(
            f"BUILD_FOLDER @@ {BUILD_OUTPUT_FOLDER_NAME}/{BUILD_OUTPUT_FOLDER_UPDATER_NAME} and {BUILD_OUTPUT_FOLDER_NAME}/{BUILD_OUTPUT_FOLDER_ROOT_NAME}"
        )
    except FileExistsError:
        logger.warning("BUILD_FOLDER @@ Already exists, skipping...")
    except PermissionError:
        logger.error("BUILD_FOLDER @@ Permission error!")
    except Exception as e:
        logger.error(f"BUILD_FOLDER @@ Error occured while initting {e}")


def run_flutter_build(curr_dir: str | None = None) -> int:
    logger.info(f"RUN_FLUTTER_BUILD @@ {curr_dir}")
    if not curr_dir:
        curr_dir = "."
    start_build_time: float = time.time()
    logger.info(f"Build started at {start_build_time}")
    flutter_build: subprocess.CompletedProcess[str] = subprocess.run(
        ["flutter.bat", "build", target_platform, "--release" if release_build else ""],
        cwd=os.path.join(os.getcwd(), curr_dir),
        stderr=subprocess.STDOUT,
        stdout=subprocess.PIPE,
        text=True,
    )
    # might need to finish some encoding issues with the output
    logger.info(
        f"FLUTTER_BUILD @@ TOOK: {time.time()-start_build_time} {curr_dir}\nOUTPUT [{flutter_build.returncode}]\n{flutter_build.stdout}"
    )
    return flutter_build.returncode


def mv_cpyfolders(src: str, dest: str):
    logger.info(f"MV_COPY_FOLDERS @@ {src} -> {dest}")
    logger.info(f"SRC_TREE -> {os.listdir(src)}")
    logger.info(f"DEST_TREE (ExpectBlank) -> {os.listdir(dest)}")
    shutil.copytree(src, dest, symlinks=True, dirs_exist_ok=True)


# actual routine processing goes here
if __name__ == "__main__":
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
        os.path.join(BUILD_OUTPUT_FOLDER_NAME, BUILD_OUTPUT_FOLDER_ROOT_NAME),
    )
    logger.info("============= END =============")
