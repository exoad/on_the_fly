# Default build file used
import os
import sys
import logging
import subprocess
import traceback

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


def run_flutter_build(curr_dir: str | None = None):
    logger.info(f"RUN_FLUTTER_BUILD @@ {curr_dir}")
    if not curr_dir:
        curr_dir = "."
    flutter_build: subprocess.CompletedProcess[str] = subprocess.run(
        ["flutter", "build", target_platform, "--release" if release_build else ""],
        cwd=os.path.join(os.getcwd(), curr_dir),
        capture_output=True,
        text=True,
    )
    logger.info(f"FLUTTER_BUILD @@ {curr_dir}\nOUTPUT\n{flutter_build}")


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
        file_handler = logging.FileHandler(
            os.path.join(BUILD_OUTPUT_FOLDER_NAME, BUILD_LOG_FILE_NAME)
        )
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(formatter)
        logger.addHandler(file_handler)
    target_platform = "windows"  # only supporting windows for now
    logger.info("============ BEGIN ============")
    logger.info(f"RELEASE_BUILD={release_build}")
    try:
        run_flutter_build()
    except Exception:
        logger.error(f"{traceback.format_exc()}")
