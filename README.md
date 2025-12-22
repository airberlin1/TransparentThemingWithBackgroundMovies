# Dependencies
There are no hard dependencies other than bash and python3 for the general theming program.
It is designed to work with hyprland, and adding support for dwm is planned. Some app configurations will not work on other platforms. There are also some dependencies for pre-configured apps, apart from the app itself:
| Dependency | Used For | Get it on Arch | Get in on Void |
| ------ | ------- | ------ | ------- |
| betterdiscord | discord | [Website](https://betterdiscord.app/) | [Website](https://betterdiscord.app/) |
| mpvpaper | background | [mpvpaper (AUR)](https://aur.archlinux.org/packages/mpvpaper) | [mpvpaper](https://voidlinux.pkgs.org/current/voidlinux-main-x86_64/mpvpaper-1.8_1.x86_64.xbps.html) |
| openrgb | hardware | [openrgb](https://archlinux.org/packages/extra/x86_64/openrgb/) | [openrgb](https://voidlinux.pkgs.org/current/voidlinux-main-aarch64/openrgb-0.9_5.aarch64.xbps.htmlxs) |
| jq | kitty, zathura | [jq](https://archlinux.org/packages/extra/x86_64/jq/) | [jq](https://voidlinux.pkgs.org/current/voidlinux-main-aarch64/jq-1.8.1_1.aarch64.xbps.html) | 
| python-hid | moonlander | [python-hid](https://archlinux.org/packages/extra/any/python-hid/) | [python3-hid](https://voidlinux.pkgs.org/current/voidlinux-main-aarch64/python3-hid-1.0.4_4.aarch64.xbps.html) |


# Setup
First, change the value of `THEMING_DIR` in `apply_theme.sh` and `load_theme.py`, and optionally also in `cycle_theme.py` and `random_theme.py`, if you want to use them, to the directory of this git repository.

Then adapt `theming.conf.d/general.conf` to your needs. You will have the option of setting the following values:

| Setting | Permitted Values | Example | Description | 
| --------| --------- | -------- | -------- |
| window_manager | hyprland | hyprland | The window manager or desktop environment used |
| displays | Comma Seperated List of Display Identifiers | DP-2,HDMI-A-3 | What displays are connected, and in what other are they to be considered? |
| movie_base_dir | any full path, should not have trailing / | /home/example/movies | path to a directory so that specified movies will be a relative path starting from here |

The syntax is

``` 
setting: value
```

# Configuration
## General

For all apps that should use special theming, you should make an entry in `theming.conf.d/configured_apps.conf`. 

## Themes

Themes are set in the theme subdirectory. The name of the theme file will be used to determine the themes name. 
With a file `default` in this directory, you can set default values for things you do not wish to specify seperately in every theme. There is also the option to define a fallback, for example for the hardware_col:

```
hardware_col: fallback,dark
```
would specify dark as the fallback color for hardware_col, if you have not specified hardware_col in a theme.
All values you set in a theme file (given they follow the syntax 'name: value' or 'name: rgb,red,blue,green'), should be able to work immediately.

But, how does anything work? The default behavior is to load all themes with `load_themes.py`. By doing so, all files found in the blanks folder of all configured apps will have occurences of `%%%name%%%` replaced with the given value for each theme. There are some additional options for colors. The string `%%%color_name:hex%%%` will be replaced by `#rrggbb`, while `%%%color_name:rgba:opacity:0.7%%%` will be replaced with `rgba(red, green, blue, 0.7)`. Apply theme then calls the main script for each configured app with information about which theme to enable. These scripts now use the previously filled configuration files to change the color and appearance of apps, backgrounds, or hardware RGBs.

## Missing Configs
I have adapted [Discord+](https://github.com/PlusInsta/discord-plus) for discord, but as I am not sure how I would have to deal with the missing license there I will not provide the config.


## How to add an app to configured_apps
Add the name of the app to `theming.conf.d/configured_apps.conf`. Then create a directory with the same name, and add an executable `main.sh` in it. If you want any dynamic configuration files or values for this application, you can add a blank file in the subdirectory `configs`, for examble `app_name/configs/app_name.css`. Note that these files cannot contain the character `-`. There are two values given to `main.sh`. The first is the name of the theme and the second is the absolute path of the theming directory. You can access your filled out blanks with `$2/app_name/configs/app_name.css-$1`. You also have access to the general settings by calling `$("$2/get_general_config.py" setting "$2")`.

If you want, you can add a readme in the folder so that you can later understand what you did.

