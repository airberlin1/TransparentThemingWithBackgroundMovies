#!/usr/bin/env python3

from tkinter import *
from tkinter import ttk
from subprocess import call
from functools import partial
import os

THEMING_DIR = f"{os.environ["HOME"]}/TransparentThemingWithBackgroundMovies"

root = Tk(className="select_theme")

def select_theme(selected_theme):
    root.destroy()
    call([f"{THEMING_DIR}/apply_theme.sh", selected_theme])


def main():
    with open(f"{THEMING_DIR}/current_theme", "r") as fp:
        current_theme = fp.read().strip()
    loaded_themes = []
    with open(f"{THEMING_DIR}/loaded_themes", "r") as fp:
        for t in fp.readlines():
            loaded_themes.append(t.strip())
    loaded_themes.remove(current_theme)
    loaded_themes = [current_theme] + loaded_themes
    root.geometry(f"400x{50*len(loaded_themes)+100}")
    root.overrideredirect(True)
    root.wait_visibility(root)
    root.wm_attributes("-alpha", 0.5)

    # allow non action to close the window again
    root.bind("<Escape>", lambda x: root.destroy())
    root.bind("<Control-q>", lambda x: root.destroy())
    
    for i, t in enumerate(loaded_themes):
        button = Button(root, text=t,command=partial(select_theme, t),fg="blue", bg="#000000", bd=0, highlightthickness=0)
        button.place(relw=1, relh=1/(len(loaded_themes) +2), relx=0, rely=i/len(loaded_themes))
        #button.pack(ipadx=0, ipady=0)
    root.mainloop()
    


if __name__ == "__main__":
    main()
