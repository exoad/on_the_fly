# TODO: implement

import sys
import json
import ttkbootstrap as ttk
from ttkbootstrap.constants import *  # type: ignore

import shared_constants as shared


def startapp():
    app = ttk.Window(title="OnTheFly Updater", minsize=[280, 420], size=[400, 600])
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
    main_title_p1 = ttk.Label(app, text="OnTheFly", foreground=shared.POPROCK_FG1)
    main_title_p1.pack(side=LEFT, padx=4, pady=4)
    main_title_p2 = ttk.Label(app, text=" Updater", foreground=shared.POPROCK_FG2)
    main_title_p2.pack(side=RIGHT, padx=4, pady=4)

    app.mainloop()


if __name__ == "__main__":
    startapp()
