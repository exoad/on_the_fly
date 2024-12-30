# TODO: implement

import sys
import json
import ttkbootstrap as ttk
from ttkbootstrap.constants import *
import webbrowser
import shared_constants as shared
import audit_base
import requests

def startapp(audit: audit_base.AuditJSON):
    app = ttk.Window(
        title="OnTheFly Updater",
        minsize=shared.WINDOW_GEOM,
        size=shared.WINDOW_GEOM,
        maxsize=shared.WINDOW_GEOM,
        themename="minty",
        resizable=(False, False),
    )

    # for debugging purposes
    app.bind("<Control-c>", lambda event: app.destroy())
    # center window from https://stackoverflow.com/a/76796149 :D thank you !
    app.update()
    s_width = app.winfo_screenwidth()
    s_height = app.winfo_screenheight()
    border_width = app.winfo_rootx() - app.winfo_x()
    tb_height = app.winfo_rooty() - app.winfo_y()
    app.geometry(
        "+%d+%d"
        % (
            (s_width - (app.winfo_width() + (border_width * 2))) // 2,
            (s_height - (app.winfo_height() + tb_height + border_width)) // 2,
        )
    )
    main_title = ttk.Label(
        app,
        text="OnTheFly",
        foreground=shared.POPROCK_FG1,
        font=ttk.font.Font(size=18, weight="bold"),
    )
    main_title.pack(
        anchor="w",
        side="top",
        pady=(shared.TOTAL_CONTENT_MARGIN, 0),
        padx=(shared.TOTAL_CONTENT_MARGIN, 0),
    )
    sub_title = ttk.Label(
        app, text=f"Updater program v{shared.UPDATER_PROGRAM_VERSION_ITER}"
    )
    sub_title.pack(anchor="w", side="top", padx=(shared.TOTAL_CONTENT_MARGIN, 0))
    issue_tracker_ax = ttk.Button(
        text="Issue Tracker",
        command=lambda: webbrowser.open(shared.UPDATER_PROGRAM_ISSUE_TRACKER_URL),
    )
    issue_tracker_ax.pack(
        anchor="w", side="top", padx=(shared.TOTAL_CONTENT_MARGIN, 0), pady=(6, 0)
    )
    title_element_sep = ttk.Separator(app)
    title_element_sep.pack(
        side="top", padx=shared.TOTAL_CONTENT_MARGIN, pady=(6, 10), fill="x"
    )
    status_update_title = ttk.Label(
        text="Current status:", font=ttk.font.Font(weight="bold")
    )
    status_update_title.pack(side="top", padx=shared.TOTAL_CONTENT_MARGIN, pady=(0, 4))

    app.mainloop()


if __name__ == "__main__":
    # TODO: implement a way to fetch the status of the current program
    if len(sys.argv) < 1:
        exit(shared.ERRN_NO_CURRENT_VERSION_SUPPLIED)
    curr_ver = sys.argv[1]  # the current installed version code
    audit = requests.get(shared.AUDIT_JSON_URL).json()
    # print(f"{type(audit_res_json)} {audit_res_json}")
    if curr_ver[1:].isdigit() if curr_ver[0] in ("-", "+") else curr_ver.isdigit():
        curr_ver = int(curr_ver)
        if curr_ver < audit["iteration"]:
            out_of_date = True
        else:
            # launch the program normally
            audit = audit_base.AuditJSON(
                iteration=audit["iteration"],
                version_tag=audit["version_tag"],
                source_download=audit["source_download"],
                platform=[
                    plat
                    for k, v in audit["platform"].items()
                    if (
                        plat := audit_base.PlatformDownloadJSON(
                            name=k, release_url=v["release_url"], checksum=v["checksum"]
                        )
                    )
                ],
            )
            startapp(audit)
            print(audit)
    else:
        exit(shared.ERRN_NON_NUMERICAL_CURRENT_VERSION)
    # isoutofdate = True
    # startapp(isoutofdate)
